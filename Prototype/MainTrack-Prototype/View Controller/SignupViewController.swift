//
//  SignupViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth
import DropDown

class SignupViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var reEnterPasswordText: UITextField!
    @IBOutlet weak var roleButton: RoundedButton!
    @IBOutlet weak var anchorView: UIView!
    
    let apiClient = ApiClient.shared
    let loadingView = LoadingView()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.dataSource = Role.allCases.map { $0.rawValue.capitalized }
        dropDown.anchorView = anchorView
    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        reEnterPasswordText.resignFirstResponder()
    }
    
    @IBAction func onChooseRoleTapped(_ sender: Any) {
        dropDown.show()
        dropDown.selectionAction = { _, item in
            self.roleButton.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onSubmitButtonTapped(_ sender: Any) {
        do {
            let newUserData = try getUserDataFromInput()
            loadingView.show(in: view)
            tryAdding(newUserData)
        } catch let error {
            presentBasicAlert(title: "Error signing up", message: error.localizedDescription)
        }
    }
    
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func getUserDataFromInput() throws -> UserData {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty,
              let reEnterPassword = reEnterPasswordText.text, !reEnterPassword.isEmpty,
              let roleString = roleButton.currentTitle, !roleString.isEmpty
        else {
            throw ValidationError.missingData
        }
        
        guard password == reEnterPassword else { throw ValidationError.passwordMismatch }
        
        guard let role = Role.init(rawValue: roleString.lowercased()) else { throw ValidationError.roleNotFound }
        
        return UserData(email, password, role)
    }
    
    private func tryAdding(_ newUser: UserData) {
        apiClient.checkUserExists(with: newUser.email) { userExists in
            if userExists {
                self.loadingView.remove()
                self.presentBasicAlert(title: "Error signing up", message: "An account already exists for \(newUser.email)")
            } else {
                self.create(newUser)
            }
        }
    }
    
    private func create(_ newUser: UserData) {
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { _, error in
            self.loadingView.remove()
            if let error = error {
                self.presentBasicAlert(title: "Error signing up", message: error.localizedDescription)
            } else {
                self.apiClient.post(newUser)
                self.presentReturningAlert(title: "Success!", message: "You'll be redirected to sign in")
            }
        }
    }
}

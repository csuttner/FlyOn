//
//  SignupViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    let signUpView = SignUpView()
    let apiClient = ApiClient.shared
    let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupSubviews()
        addTapGesture()
        addButtonTargets()
    }
    
    private func setupSubviews() {
        view.addSubview(signUpView)
        signUpView.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            width: .loginViewWidth
        )
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func addButtonTargets() {
        signUpView.submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
        signUpView.cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func onTap() {
        signUpView.dismissKeyboard()
    }
    
    @objc func onSubmitButtonTapped() {
        do {
            let newUserData = try getUserDataFromInput()
            loadingView.show(in: view)
            tryAdding(newUserData)
        } catch let error {
            presentBasicAlert(title: "Error signing up", message: error.localizedDescription)
        }
    }
    
    @objc func onCancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getUserDataFromInput() throws -> UserData {
        guard let email = signUpView.emailText.text, !email.isEmpty,
              let password = signUpView.passwordText.text, !password.isEmpty,
              let reenterPassword = signUpView.reenterPasswordText.text, !reenterPassword.isEmpty,
              let roleString = signUpView.roleButton.currentTitle, !roleString.isEmpty
        else {
            throw ValidationError.missingData
        }
        
        guard password == reenterPassword else { throw ValidationError.passwordMismatch }
        
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

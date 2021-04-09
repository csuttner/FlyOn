//
//  LoginViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    private let loadingView = LoadingView()
    private let apiClient = ApiClient.shared

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.isToolbarHidden = true
        setTextWithUserData()
    }
    
    private func setTextWithUserData() {
        if let userData = userData {
            emailText.text = userData.email
            passwordText.text = userData.password
            emailText.textColor = .black
        }
    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        do {
            let (email, password) = try getEmailPasswordFromInput()
            loadingView.show(in: view)
            signIn(email: email, password: password)
        } catch let error {
            presentBasicAlert(title: "Login Failed", message: error.localizedDescription)
        }
    }
    
    @IBAction func onSignUpButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    private func getEmailPasswordFromInput() throws -> (String, String) {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty
        else {
            throw ValidationError.missingData
        }
        return (email, password)
    }
    
    private func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.loadingView.remove()
                self.presentBasicAlert(title: "Login failed", message: error.localizedDescription)
            } else {
                self.didSignIn(with: email)
            }
        }
    }
    
    private func didSignIn(with email: String) {
        apiClient.getUserData(from: email) { data in
            userData = data
            self.loadingView.remove()
            self.navigationController?.pushViewController(OldDefectViewController(), animated: true)
        }
    }
}

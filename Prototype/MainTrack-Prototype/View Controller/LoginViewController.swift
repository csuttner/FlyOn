//
//  LoginViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let apiClient = ApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupSubviews()
        addTapGesture()
        addButtonTargets()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.isToolbarHidden = true
    }
    
    private func setupSubviews() {
        view.addSubview(loginView)
        loginView.anchor(
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
        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func onTap() {
        loginView.dismissKeyboard()
    }
    
    @objc func onLoginButtonTapped() {
        do {
            let (email, password) = try getEmailPasswordFromInput()
            signIn(email: email, password: password)
        } catch let error {
            print("Error logging in: \(error)")
        }
    }
    
    @objc func onSignUpButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    private func getEmailPasswordFromInput() throws -> (String, String) {
        guard let email = loginView.emailText.text, !email.isEmpty,
              let password = loginView.passwordText.text, !password.isEmpty
        else {
            throw ValidationError.missingData
        }
        return (email, password)
    }
    
    private func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.presentBasicAlert(title: "Login failed")
            } else {
                self.didSignIn(with: email)
            }
        }
    }
    
    private func didSignIn(with email: String) {
        print("\(email) login successful")
        self.apiClient.getUserData(from: email) { data in
            userData = data
            self.navigationController?.pushViewController(DefectViewController(), animated: true)
        }
    }
    
}

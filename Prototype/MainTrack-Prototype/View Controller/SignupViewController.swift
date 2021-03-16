//
//  SignupViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class SignupViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupSubviews()
        addTapGesture()
        addButtonActions()
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
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(onTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTap() {
        signUpView.dismissKeyboard()
    }
    
    private func addButtonActions() {
        signUpView.submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
        signUpView.cancelButton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
    }
    
    private func addNewUser() throws {
        
    }
    
    private func getNewUserFromInput() throws -> User {
        guard let email = signUpView.emailText.text, !email.isEmpty,
              let password = signUpView.passwordText.text, !password.isEmpty,
              let reenterPassword = signUpView.reenterPasswordText.text, !reenterPassword.isEmpty,
              let roleString = signUpView.roleText.text, !roleString.isEmpty
        else {
            throw ValidationError.missingData
        }
        
        guard password == reenterPassword else { throw ValidationError.passwordMismatch }
        
        guard let role = Role(rawValue: roleString) else { throw ValidationError.roleNotFound }
        
        return User(email, password, role)
    }
    
    @objc func onSubmitButtonTapped() {
        do {
            let user = try getNewUserFromInput()
            try ApiClient.shared.post(user)
            presentReturningAlert(title: "Success!", message: "You'll be redirected to sign in")
        } catch let error {
            presentBasicAlert(title: "Error signing up", message: error.localizedDescription)
        }
    }
    
    @objc func onCancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

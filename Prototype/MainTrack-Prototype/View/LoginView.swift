//
//  LoginView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class LoginView: UIView {
    
    public let emailText = PlaceholderTextView(placeholder: "Email")
    public let passwordText = PlaceholderTextView(placeholder: "Password")
    
    public lazy var loginButton = ActionButton(title: "Login", color: .systemBlue)
    public lazy var signUpButton = ActionButton(title: "Sign Up", color: .systemGreen)
    
    private lazy var stack = UIStackView(
        arrangedSubviews: [
            emailText,
            passwordText,
            loginButton,
            signUpButton
        ]
    ).withAttributes(spacing: .padding)
    
    convenience init() {
        self.init(frame: .zero)
        setupSubviews()
        format()
    }
    
    private func setupSubviews() {
        addSubview(stack)
        stack.pin(to: self, padding: .padding)
    }
    
    private func format() {
        layer.cornerRadius = .cornerRadius
        backgroundColor = .systemBackground
    }

    public func dismissKeyboard() {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
}

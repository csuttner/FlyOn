//
//  SignUpView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit

class SignUpView: UIView {
    
    let emailText = PlaceholderTextView(placeholder: "Email")
    let passwordText = PlaceholderTextView(placeholder: "Password")
    let reenterPasswordText = PlaceholderTextView(placeholder: "Re-enter Password")
    let roleText = PlaceholderTextView(placeholder: "Role")
    
    let submitButton = ActionButton(title: "Submit", color: .systemGreen)
    let cancelButton = ActionButton(title: "Cancel", color: .systemGray)
    
    lazy var stack = UIStackView(
        arrangedSubviews: [
            emailText,
            passwordText,
            reenterPasswordText,
            roleText,
            submitButton,
            cancelButton
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
        for subview in stack.arrangedSubviews {
            subview.resignFirstResponder()
        }
    }
    
}

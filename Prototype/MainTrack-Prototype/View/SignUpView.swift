//
//  SignUpView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/12/21.
//

import UIKit
import DropDown

class SignUpView: UIView {
    
    let emailText = PlaceholderTextView(placeholder: "Email")
    let passwordText = PlaceholderTextView(placeholder: "Password")
    let reenterPasswordText = PlaceholderTextView(placeholder: "Re-enter Password")
//    let roleText = PlaceholderTextView(placeholder: "Role")
    
    let roleAnchor = UIView()
    
    let dropDown = DropDown()
    
    let roleButton = ActionButton(title: "Choose Role", color: .systemBlue, target: self, action: #selector(onChooseRoleTapped))
    let submitButton = ActionButton(title: "Submit", color: .systemGreen)
    let cancelButton = ActionButton(title: "Cancel", color: .systemGray)
    
    lazy var roleStack = UIStackView(arrangedSubviews: [roleButton, roleAnchor]).withAttributes(axis: .vertical)
    
    lazy var stack = UIStackView(
        arrangedSubviews: [
            emailText,
            passwordText,
            reenterPasswordText,
            roleStack,
            submitButton,
            cancelButton
        ]
    ).withAttributes(spacing: .padding)
    
    convenience init() {
        self.init(frame: .zero)
        dropDown.dataSource = Role.allCases.map { $0.rawValue.capitalized }
        dropDown.anchorView = roleAnchor
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
    
    @objc func onChooseRoleTapped() {
        dropDown.show()
        dropDown.selectionAction = { _, item in
            self.roleButton.setTitle(item, for: .normal)
        }
    }
}

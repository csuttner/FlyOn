//
//  LoginView.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import UIKit

class LoginView: UIView {
    let employeeIdText = PlaceholderTextView(placeholder: "Employee ID")
    let passwordText = PlaceholderTextView(placeholder: "Password")
    
    let loginButton = ActionButton(title: "Login", color: .systemBlue)
    let signupButton = ActionButton(title: "Sign Up", color: .systemGreen)
    
    lazy var textStack = VerticalPaddedStack(distribution: .fillProportionally, arrangedSubviews: [
        employeeIdText,
        passwordText
    ])
    
    lazy var buttonStack = VerticalPaddedStack(distribution: .fillEqually, arrangedSubviews: [
        loginButton,
        signupButton
    ])
    
    lazy var stack = VerticalPaddedStack(distribution: .fill, arrangedSubviews: [
        textStack,
        buttonStack
    ])
    
    convenience init(superviewFrame: CGRect) {
        self.init(frame: superviewFrame.squareWidthDivided(by: 1.5))
        formatView()
        setupStack()
    }
    
    private func formatView() {
        backgroundColor = .systemGray
        layer.cornerRadius = .cornerRadius
    }
    
    private func setupStack() {
        addSubview(stack)
        stack.frame = bounds.inset(by: .mainPadding)
    }
}

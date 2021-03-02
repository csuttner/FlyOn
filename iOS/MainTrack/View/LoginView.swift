//
//  LoginView.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import UIKit

class LoginView: UIView {
    let emplIdText = UITextView()
    let passwordText = UITextView()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.sizeToFit()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = .cornerRadius
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emplIdText,
            passwordText,
            loginButton
        ])
        stack.frame = bounds.inset(by: .mainPadding)
        stack.distribution = .fillEqually
        stack.spacing = .mainPadding
        stack.axis = .vertical
        return stack
    }()
    
    convenience init(superviewFrame: CGRect) {
        self.init(frame: superviewFrame.squareWidthDivided(by: 1.5))
        backgroundColor = .systemGray
        layer.cornerRadius = .cornerRadius
        addSubview(stack)
    }
}

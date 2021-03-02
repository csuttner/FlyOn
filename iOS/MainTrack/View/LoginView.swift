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
    let loginButton = UIButton()
    
    lazy var stack = UIStackView(arrangedSubviews: [
        emplIdText,
        passwordText,
        loginButton
    ])
    
    convenience init(superviewFrame: CGRect) {
        self.init(frame: superviewFrame.squareWidthDivided(by: 1.5))
        backgroundColor = .systemGray
        layer.cornerRadius = 8
        
        setupStack()
        
        loginButton.setTitle("login", for: .normal)
        loginButton.sizeToFit()
        loginButton.backgroundColor = .systemBlue
        
    }
    
    func setupStack() {
        addSubview(stack)
        stack.frame = bounds.insetBy(dx: .mainPadding, dy: .mainPadding)
        stack.axis = .vertical
        stack.alignment = .center
    }
}

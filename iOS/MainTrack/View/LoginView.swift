//
//  LoginView.swift
//  MainTrack
//
//  Created by Clay Suttner on 3/1/21.
//

import UIKit

class LoginView: UIView {
    let stack = UIStackView()
    let emplIdText = UITextView()
    let passwordText = UITextView()
    let loginButton = UIButton()
    
    convenience init(superviewFrame: CGRect) {
        self.init(frame: superviewFrame.squareWidthDivided(by: 2))
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(stack)
        stack.addArrangedSubview(emplIdText)
        stack.addArrangedSubview(passwordText)
        stack.addArrangedSubview(loginButton)
    }
}

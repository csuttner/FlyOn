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
        addSubmitButtonAction()
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
    
    private func addSubmitButtonAction() {
        signUpView.submitButton.addTarget(self, action: #selector(onSubmitButtonTapped), for: .touchUpInside)
    }
    
    @objc func onSubmitButtonTapped() {
        
    }
}

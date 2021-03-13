//
//  LoginViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    private var userModel: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationController()
        setupSubviews()
        addButtonTargets()
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray6
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubviews() {
        view.addSubview(loginView)
        loginView.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            width: .loginViewWidth
        )
    }
    
    private func addButtonTargets() {
        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func onLoginButtonTapped() {
        navigationController?.pushViewController(DefectViewController(), animated: true)
    }
    
    @objc func onSignUpButtonTapped() {

    }
    
}

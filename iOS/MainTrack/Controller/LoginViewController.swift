//
//  ViewController.swift
//  MainTrack
//
//  Created by Clay Suttner on 2/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    lazy var loginView = LoginView(superviewFrame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        view.backgroundColor = .systemBackground
        
        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func onLoginButtonTapped() {
        navigationController?.pushViewController(DefectTableViewController(), animated: true)
    }
}



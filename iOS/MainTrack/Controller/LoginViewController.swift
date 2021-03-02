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
    }
}



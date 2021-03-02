//
//  ViewController.swift
//  MainTrack
//
//  Created by Clay Suttner on 2/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
    }
}



//
//  LoginViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    private let loadingView = LoadingView()
    private let apiClient = ApiClient.shared

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        if let emailString = UserDefaults().value(forKey: "email") as? String,
           let passwordString = UserDefaults().value(forKey: "password") as? String{
            emailText.text = emailString
            passwordText.text = passwordString
        }
    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        do {
            let (email, password) = try getEmailPasswordFromInput()
            loadingView.show(in: view)
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.loadingView.remove()
                    self.presentBasicAlert(title: "Login failed", message: error.localizedDescription)
                } else {
                    UserDefaults().setValue(email, forKey: "email")
                    UserDefaults().setValue(password, forKey: "password")
                    self.apiClient.getUserData(from: email) { data in
                        userData = data
                        self.loadingView.remove()
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                }
            }
        } catch let error {
            presentBasicAlert(title: "Login Failed", message: error.localizedDescription)
        }
    }

    private func getEmailPasswordFromInput() throws -> (String, String) {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty
        else {
            throw ValidationError.missingData
        }
        return (email, password)
    }
}

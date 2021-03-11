//
//  SignupViewController.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/10/21.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var employeeIdText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var reenterPasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(onTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTap() {
        employeeIdText.resignFirstResponder()
        emailText.resignFirstResponder()
        firstNameText.resignFirstResponder()
        lastNameText.resignFirstResponder()
        passwordText.resignFirstResponder()
        reenterPasswordText.resignFirstResponder()
    }
    
}

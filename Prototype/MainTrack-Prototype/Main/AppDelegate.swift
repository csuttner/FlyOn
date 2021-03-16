//
//  AppDelegate.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().signIn(withEmail: "csuttner@gmail.com", password: "maintrack") { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("login successful")
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        window?.makeKeyAndVisible()
        return true
    }

}


//
//  LoginVC.swift
//  Top3
//
//  Created by Iulian Crisan on 02/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn


class LoginVC: UIViewController {
    
    var loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @objc func loginWithGoogle() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}




// Handle sign in
extension LoginVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
        }
    }

}




// User interface
extension LoginVC {
    
    func initUI() {
        view.backgroundColor = .systemBackground
        initLoginButton()
    }
    
    func initLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.setTitle("Login with Google", for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginWithGoogle), for: .touchUpInside)
    }
    
}
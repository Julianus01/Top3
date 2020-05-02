//
//  LoginVC.swift
//  Top3
//
//  Created by Iulian Crisan on 02/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
}

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
        loginButton.setTitle("Login", for: .normal)
    }
    
}

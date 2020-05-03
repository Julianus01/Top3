//
//  HomeVC.swift
//  Top3
//
//  Created by Iulian Crisan on 03/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {
    
    private let user = Auth.auth().currentUser
    var titleLabel = UILabel()
    var logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    @objc func logout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch let error {
            print("Error on logout \(error.localizedDescription)")
        }
    }
    
}

extension HomeVC {
    
    func initUI(){
        view.backgroundColor = .systemBackground
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.text = user?.email
        
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        logoutButton.setTitle("Logout", for: .normal)
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
}

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
        
        styleUI()
        navigationItem.title = "Top 3"
        tabBarItem.imageInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: -10.0, right: 0.0)
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
    
    func styleUI(){
        styleVC()
        styleTitle()
        styleLogoutButton()
    }
    
    func styleVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func styleTitle() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.text = user?.email
    }
    
    func styleLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        logoutButton.setTitle("Logout", for: .normal)
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
}

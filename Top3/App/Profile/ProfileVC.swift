//
//  ProfileVC.swift
//  Top3
//
//  Created by Iulian Crisan on 04/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    var logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        styleUI()
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
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




// MARK: User Interface
extension ProfileVC {
    
    func styleUI() {
        styleVC()
        styleLogoutButton()
    }
    
    func styleVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func styleLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(22)
        }
    }
    
}

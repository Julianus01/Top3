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
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        title = "Top 3"
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        titleLabel.text = user?.email
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




// MARK: USER INTERFACE
extension HomeVC {
    
    func styleUI(){
        styleVC()
        styleScrollView()
        styleContentView()
        styleTitle()
        styleLogoutButton()
    }
    
    func styleVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func styleScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func styleContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
//        let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
//        let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0
//        let constant = statusBarHeight + navBarHeight + tabBarHeight
//        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.bounds.height - constant).isActive = true
    }
    
    func styleTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        
        titleLabel.numberOfLines = 0
    }
    
    func styleLogoutButton() {
        contentView.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        logoutButton.setTitle("Logout", for: .normal)
    }
    
}

//
//  Top3VC.swift
//  Top3
//
//  Created by Iulian Crisan on 03/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

class Top3VC: UIViewController {
    
    private let user = Auth.auth().currentUser
    var titleLabel = UILabel()
    var logoutButton = UIButton(type: .system)
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        title = "Top3"
        
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
extension Top3VC {
    
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
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view)
        }
    }
    
    func styleContentView() {
        scrollView.addSubview(contentView)
    
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        // let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        // let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0
        // let constant = statusBarHeight + navBarHeight + tabBarHeight
        // contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.bounds.height - constant).isActive = true
    }
    
    func styleTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(22)
            make.left.equalTo(contentView).offset(22)
            make.right.equalTo(contentView).offset(-22)
        }
    }
    
    func styleLogoutButton() {
        contentView.addSubview(logoutButton)
        logoutButton.setTitle("Logout", for: .normal)
        
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalTo(contentView).offset(22)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
}

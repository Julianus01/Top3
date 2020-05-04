//
//  TabBarVC.swift
//  Top3
//
//  Created by Iulian Crisan on 04/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = UINavigationController(rootViewController: HomeVC())
        let firstVCIcon = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        firstVC.tabBarItem = UITabBarItem(title: "", image: firstVCIcon, tag: 0)
        
        let secondVC = UINavigationController(rootViewController: ProfileVC())
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers = [firstVC, secondVC]
    }
    
}

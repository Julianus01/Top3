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
        
        let firstVC = UINavigationController(rootViewController: Top3VC())
        let firstVCIcon = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: firstVCIcon, tag: 0)
        
        let secondVC = UINavigationController(rootViewController: ProfileVC())
        let secondVCIcon = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)
        secondVC.tabBarItem = UITabBarItem(title: "Profile", image: secondVCIcon, tag: 0)
        
        viewControllers = [firstVC, secondVC]
    }
    
}

//
//  ViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 27/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import SwiftSoup
import WebKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBarController?.viewControllers = self.setUpViewControllers()
        _ = self.tabBarController?.viewControllers?.map { UINavigationController(rootViewController: $0) }
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 11.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    func setUpViewControllers () -> [UIViewController] {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let financialsVC = FinancialsViewController()
        financialsVC.title = "Financials"
        financialsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let schedulesVC = SchedulesTableViewController()
        schedulesVC.title = "Schedules"
        schedulesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        let gpaVC = GPAViewController()
        gpaVC.title = "GPA"
        gpaVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        
        return [homeVC, financialsVC, schedulesVC, gpaVC]
    }

}


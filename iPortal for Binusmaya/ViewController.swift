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
        
        self.tabBarController?.viewControllers?.forEach { let _ = $0.view }
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 11.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }

}


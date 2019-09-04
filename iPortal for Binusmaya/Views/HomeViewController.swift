//
//  HomeViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 26/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeViewController: UIViewController {

    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileBarStackView: UIStackView!
    
    @IBOutlet weak var profileBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    func setupUI () {
        self.setupProfileBar()
    }
    
    func setupProfileBar () {
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
}

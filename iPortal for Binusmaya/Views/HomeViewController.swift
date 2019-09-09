//
//  HomeViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 26/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
    
    var screenSize: CGRect = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenSize = UIScreen.main.bounds
        self.setupUI()
    }
    
    func setupUI () {
        let origin = CGPoint(x: 0, y: Screen.safeAreaTop)
        let size = CGSize(width: self.screenSize.width, height: self.screenSize.height)
        
        let scrollNode = ASScrollNode()
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.frame = CGRect(origin: origin, size: size)
        
//        scrollNode.backgroundColor = UIColor.blue
        scrollNode.scrollableDirections = .init(arrayLiteral: [.up, .down])
        
        scrollNode.layoutSpecBlock = { node, constrainedSize -> ASLayoutSpec in
            return self.getScrollNodeLayoutSpecBlock()
        }
        
        let wrapperViewNode = ASDisplayNode()
        wrapperViewNode.frame = CGRect(origin: origin, size: size)
        wrapperViewNode.addSubnode(scrollNode)
        
        self.view.addSubnode(wrapperViewNode)
    }
    
    func getScrollNodeLayoutSpecBlock () -> ASLayoutSpec {
        let scrollNodeWrapper = ASStackLayoutSpec.vertical()
        scrollNodeWrapper.style.width = ASDimensionMakeWithPoints(self.screenSize.width)
        scrollNodeWrapper.style.height = ASDimensionMakeWithPoints(self.screenSize.height)
        
        scrollNodeWrapper.children = [
            self.profileBar(),
            self.scheduleBar()
        ]
        
        return scrollNodeWrapper
    }
    
    func profileBar () -> ASLayoutSpec {
        let origin = CGPoint(x: 0, y: 0)
        
        let profileBarStackNode = ASStackLayoutSpec()
        profileBarStackNode.direction = .horizontal
        profileBarStackNode.justifyContent = .spaceBetween
        profileBarStackNode.alignItems = .center
        profileBarStackNode.spacing = 40
        
        let profileBarUsername = ASTextNode()
        let profileBarUsernameAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 20)
        ]
        profileBarUsername.frame = CGRect(origin: origin, size: CGSize(width: 40, height: 100))
        profileBarUsername.attributedText = NSAttributedString(
            string: "Kevin Yulias",
            attributes: profileBarUsernameAttributes as [NSAttributedString.Key : Any]
        )
        
        let profileBarImage = ASImageNode()
        profileBarImage.image = UIImage(named: "mock-profile")
        profileBarImage.frame = CGRect(origin: origin, size: CGSize(width: 45, height: 45))
        profileBarImage.style.maxHeight = ASDimensionMakeWithPoints(45)
        profileBarImage.style.maxWidth = ASDimensionMakeWithPoints(45)
        profileBarImage.layer.cornerRadius = profileBarImage.frame.height / 2
        profileBarImage.layer.masksToBounds = false
        profileBarImage.clipsToBounds = true
        
        profileBarStackNode.children = [
            profileBarUsername,
            profileBarImage
        ]
        
        let size = CGSize(width: 500, height: 100)
        let profileBarBackground = ASDisplayNode()
        profileBarBackground.frame = CGRect(origin: origin, size: size)
//        profileBarBackground.backgroundColor = UIColor.green
        
        let wrap = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: profileBarStackNode)
        
        let profileBarWrapper = ASBackgroundLayoutSpec(child: wrap, background: profileBarBackground)
        profileBarWrapper.style.maxWidth = ASDimensionMakeWithPoints(100)
        
        let profileBarInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let profileBarInsetWrapper = ASInsetLayoutSpec(insets: profileBarInset, child: profileBarWrapper)
        
        return profileBarInsetWrapper
    }
    
    func scheduleBar () -> ASLayoutSpec {
        let schedulesStackNode = ASStackLayoutSpec()
        schedulesStackNode.direction = .vertical
        schedulesStackNode.frame = CGRect(
        
        let scheduleBarInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let scheduleBarWrapper = ASInsetLayoutSpec(insets: scheduleBarInset, child: <#T##ASLayoutElement#>)
    }
}


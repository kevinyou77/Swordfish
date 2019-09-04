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
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: self.screenSize.width, height: self.screenSize.height)
        
        let scrollNode = ASScrollNode()
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.frame = CGRect(origin: origin, size: size)
        
        scrollNode.backgroundColor = UIColor.blue
        scrollNode.scrollableDirections = .init(arrayLiteral: [.up, .down])
        
        scrollNode.layoutSpecBlock = { node, constrainedSize -> ASLayoutSpec in
            return self.getScrollNodeLayoutSpecBlock()
        }
        
        let wrapperViewNode = ASDisplayNode()
        wrapperViewNode.frame = CGRect(origin: origin, size: size)
        wrapperViewNode.addSubnode(scrollNode)
        
        view.addSubnode(wrapperViewNode)
    }
    
    func getScrollNodeLayoutSpecBlock () -> ASLayoutSpec {
        let scrollNodeWrapper = ASStackLayoutSpec.vertical()
        scrollNodeWrapper.style.width = ASDimensionMakeWithPoints(self.screenSize.width)
        scrollNodeWrapper.style.height = ASDimensionMakeWithPoints(self.screenSize.height)
        
        scrollNodeWrapper.children = [
            self.profileBar(),
        ]
        
        return scrollNodeWrapper
    }
    
    func profileBar () -> ASLayoutSpec {
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: self.screenSize.width, height: 500)
        let profileBarStackNode = ASStackLayoutSpec()
        profileBarStackNode.direction = .horizontal
        profileBarStackNode.justifyContent = .center
        
        let profileBarUsername = ASTextNode()
        profileBarUsername.frame = CGRect(origin: origin, size: CGSize(width: 40, height: 100))
        profileBarUsername.attributedText = NSAttributedString(string: "Kevin Yulias", attributes: [:])
        
        let profileBarImage = ASTextNode()
        profileBarUsername.frame = CGRect(origin: origin, size: CGSize(width: 40, height: 100))
        profileBarImage.attributedText = NSAttributedString(string: "Kevin Yuliass", attributes: [:])
        
        profileBarStackNode.children = [
            profileBarUsername,
            profileBarImage
        ]
        
        let profileBarBackground = ASDisplayNode()
        profileBarBackground.frame = CGRect(origin: origin, size: size)
        profileBarBackground.backgroundColor = UIColor.green
        
        let profileBarWrapper = ASBackgroundLayoutSpec(child: profileBarStackNode, background: profileBarBackground)
        
        return profileBarWrapper
    }
}


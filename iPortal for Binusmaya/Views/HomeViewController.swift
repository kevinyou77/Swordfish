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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
//    init () {
//        super.init(node: ASDisplayNode())
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("storyboards are incompatible with truth and beauty")
//    }
    
    func setupUI () {
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 500, height: 500)
        
        let scrollNode = ASScrollNode()
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.frame = CGRect(origin: origin, size: size)
        
        scrollNode.backgroundColor = UIColor.blue
        scrollNode.scrollableDirections = .init(arrayLiteral: [.up, .down])
        scrollNode.layoutSpecBlock = { node, constrainedSize -> ASLayoutSpec in
            return self.setupProfileBar()
        }
        
        let wrapperViewNode = ASDisplayNode()
        wrapperViewNode.backgroundColor = UIColor.cyan
        wrapperViewNode.frame = CGRect(origin: origin, size: size)
        wrapperViewNode.addSubnode(scrollNode)
        
        view.addSubnode(wrapperViewNode)
    }
    
    func setupProfileBar () -> ASStackLayoutSpec {
        let profileBarStackNode = ASStackLayoutSpec()
        profileBarStackNode.direction = .horizontal
        profileBarStackNode.style.minWidth = ASDimensionMakeWithPoints(60.0)
        profileBarStackNode.style.maxHeight = ASDimensionMakeWithPoints(40.0)
        
        let profileUsernameTextNode = ASTextNode()
        profileUsernameTextNode.attributedText = NSAttributedString(
            string: "Kevin",
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 15)!
            ]
        )
        
        let profileBarStackNode1 = ASStackLayoutSpec()
        profileBarStackNode1.direction = .horizontal
        profileBarStackNode1.style.minWidth = ASDimensionMakeWithPoints(60.0)
        profileBarStackNode1.style.maxHeight = ASDimensionMakeWithPoints(40.0)
        
        let profileUsernameTextNode1 = ASTextNode()
        profileUsernameTextNode1.attributedText = NSAttributedString(
            string: "Kevinsdfs",
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 15)!
            ]
        )
        
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 100, height: 100)
        let wrapperViewNode = ASDisplayNode()
        wrapperViewNode.backgroundColor = UIColor.yellow
        wrapperViewNode.frame = CGRect(origin: origin, size: size)
        
        profileUsernameTextNode.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100))
        
        profileBarStackNode.children = [
            profileUsernameTextNode,
            profileBarStackNode1,
            wrapperViewNode
        ]
        
        return profileBarStackNode
    }
}


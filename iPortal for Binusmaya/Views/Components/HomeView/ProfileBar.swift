//
//  ProfileBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

protocol ProfileBarProtocol {
    
}

class ProfileBar {
    func render () -> ASLayoutSpec {
        let origin = CGPoint(x: 0, y: 0)
        
        let profileBarStackNode = ASStackLayoutSpec()
        profileBarStackNode.direction = .horizontal
        profileBarStackNode.justifyContent = .spaceBetween
        profileBarStackNode.alignItems = .center
        
        let profileBarUsername = ASTextNode()
        let profileBarUsernameAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 20)!
        ]
        profileBarUsername.frame = CGRect(origin: origin, size: CGSize(width: 40, height: 100))
        profileBarUsername.attributedText = NSAttributedString(
            string: "Kevin Yulias",
            attributes: profileBarUsernameAttributes
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
        
        let wrap = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: profileBarStackNode)
        
        let profileBarWrapper = ASBackgroundLayoutSpec(child: wrap, background: profileBarBackground)
        profileBarWrapper.style.maxWidth = ASDimensionMakeWithPoints(100)
        
        let profileBarInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let profileBarInsetWrapper = ASInsetLayoutSpec(insets: profileBarInset, child: profileBarWrapper)
        
        return profileBarInsetWrapper
    }
}

func profileBar () -> ASLayoutSpec {
    let origin = CGPoint(x: 0, y: 0)
    
    let profileBarStackNode = ASStackLayoutSpec()
    profileBarStackNode.direction = .horizontal
    profileBarStackNode.justifyContent = .spaceBetween
    profileBarStackNode.alignItems = .center
    
    let profileBarUsername = ASTextNode()
    let profileBarUsernameAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 20)!
    ]
    profileBarUsername.frame = CGRect(origin: origin, size: CGSize(width: 40, height: 100))
    profileBarUsername.attributedText = NSAttributedString(
        string: "Kevin Yulias",
        attributes: profileBarUsernameAttributes
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
    
    let wrap = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: profileBarStackNode)
    
    let profileBarWrapper = ASBackgroundLayoutSpec(child: wrap, background: profileBarBackground)
    profileBarWrapper.style.maxWidth = ASDimensionMakeWithPoints(100)
    
    let profileBarInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let profileBarInsetWrapper = ASInsetLayoutSpec(insets: profileBarInset, child: profileBarWrapper)
    
    return profileBarInsetWrapper
}

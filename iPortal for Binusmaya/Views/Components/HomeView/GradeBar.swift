//
//  GradeBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

// MARK: GRADE BAR
func gradeBar () -> ASLayoutSpec {
    let currentGPATextNode = ASTextNode()
    let currentGPATextNodeAttribute: [NSAttributedString.Key : Any] = [:]
    currentGPATextNode.attributedText = NSAttributedString(
        string: "3.26", attributes: currentGPATextNodeAttribute
    )
    
    let gradeBarTitle = ASStackLayoutSpec()
    gradeBarTitle.direction = .horizontal
    
    let gradeBarStackNode = ASStackLayoutSpec()
    gradeBarStackNode.direction = .vertical
    
    return gradeBarStackNode
}

// MARK: GPA BAR
func gpaBar () -> ASLayoutSpec {
    let gpaBarWrapper = ASStackLayoutSpec()
    
    return gpaBarWrapper
}

// MARK: ACTIVITY POINT BAR
func activityPointBar () -> ASLayoutSpec {
    let activityPointBar = ASStackLayoutSpec()
    
    return activityPointBar
}

// MARK: COMMUNITY SERVICE BAR
func communityServiceBar () -> ASLayoutSpec {
    let communityServiceBar = ASStackLayoutSpec()
    
    return communityServiceBar
}

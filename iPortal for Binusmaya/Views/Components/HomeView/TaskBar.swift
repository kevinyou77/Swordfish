//
//  TaskBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

/*
 TaskBar
 */

    func taskBarCell () -> ASLayoutSpec {
        let taskBarCellTitle = ASTextNode()
        let taskBarCellTitleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: Fonts.headerFont,
        ]
        taskBarCellTitle.attributedText = NSAttributedString(
            string: "ERD Diagram",
            attributes: taskBarCellTitleAttributes
        )
        
        let taskBarCellInformationDeadline = ASTextNode()
        let taskBarCellTitleDeadlineAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: Fonts.smallFont
        ]
        taskBarCellInformationDeadline.attributedText = NSAttributedString(
            string: "Besok, 11.00",
            attributes: taskBarCellTitleDeadlineAttributes
        )
        
        let taskBarCellInformationCourse = ASTextNode()
        let taskBarCellTitleCourseAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: Fonts.smallFont
        ]
        taskBarCellInformationCourse.attributedText = NSAttributedString(
            string: "Software Design Patterns",
            attributes: taskBarCellTitleCourseAttributes
        )
        
        let taskBarCellInformation = ASStackLayoutSpec()
        taskBarCellInformation.spacing = 10
        taskBarCellInformation.children = [
            taskBarCellInformationDeadline,
            taskBarCellInformationCourse
        ]
        
        let taskBarCellWrapper = ASStackLayoutSpec()
        taskBarCellWrapper.direction = .vertical
        taskBarCellWrapper.children = [
            taskBarCellTitle,
            taskBarCellInformation
        ]
        
        return taskBarCellWrapper
    }

    func taskBar () -> ASLayoutSpec {
        let taskBarTitle = ASTextNode()
        let taskBarTitleAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Colors.primaryColor,
            NSAttributedString.Key.font: Fonts.headerFont
        ]
        taskBarTitle.attributedText = NSAttributedString(
            string: "Tugas",
            attributes: taskBarTitleAttribute
        )
        
        let taskBarStackNode = ASStackLayoutSpec()
        taskBarStackNode.direction = .vertical
        taskBarStackNode.spacing = 10
        
        taskBarStackNode.children = [
            taskBarTitle,
            taskBarCell()
        ]
        
        let taskBarInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let taskBarWrapper = ASInsetLayoutSpec(insets: taskBarInset, child: taskBarStackNode)
        
        return taskBarWrapper
    }


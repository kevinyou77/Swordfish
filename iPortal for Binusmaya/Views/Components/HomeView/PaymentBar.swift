//
//  PaymentBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

// MARK: PAYMENT BAR
func paymentBar () -> ASLayoutSpec {
    let paymentBarIcon = ASImageNode()
    paymentBarIcon.image = UIImage(named: "mock-profile")
    
    let paymentBarTitle = ASTextNode()
    let paymentBarTitleAttribute: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: Colors.primaryColor,
        NSAttributedString.Key.font: Fonts.headerFont
    ]
    paymentBarTitle.attributedText = NSAttributedString(
        string: "Pembayaran",
        attributes: paymentBarTitleAttribute
    )
    
    let paymentBarHeader = ASStackLayoutSpec()
    paymentBarHeader.direction = .horizontal
    
    paymentBarHeader.children = [
        //            paymentBarIcon,
        paymentBarTitle
    ]
    
    let paymentBarCellContentAmount = ASTextNode()
    let paymentBarCellContentAmountAttribute: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: Fonts.headerFont,
    ]
    paymentBarCellContentAmount.attributedText = NSAttributedString(
        string: "Rp6.500.000",
        attributes: paymentBarCellContentAmountAttribute
    )
    
    let paymentBarCellContentDeadline = ASTextNode()
    let paymentBarCellContentDeadlineAttribute: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: Fonts.smallFont,
        NSAttributedString.Key.foregroundColor : Colors.secondaryColor
    ]
    paymentBarCellContentDeadline.attributedText = NSAttributedString(
        string: "tertagih besok",
        attributes: paymentBarCellContentDeadlineAttribute
    )
    
    let paymentBarCellContent = ASStackLayoutSpec()
    paymentBarCellContent.direction = .horizontal
    paymentBarCellContent.alignItems = .end
    paymentBarCellContent.spacing = 5
    paymentBarCellContent.children = [
        paymentBarCellContentAmount,
        paymentBarCellContentDeadline
    ]
    
    let paymentBarWrapper = ASStackLayoutSpec()
    paymentBarWrapper.direction = .vertical
    paymentBarWrapper.spacing = 10
    paymentBarWrapper.children = [
        paymentBarHeader,
        paymentBarCellContent
    ]
    
    let paymentBarWrapperInset = ASInsetLayoutSpec()
    paymentBarWrapperInset.insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    paymentBarWrapperInset.child = paymentBarWrapper
    
    return paymentBarWrapperInset
}

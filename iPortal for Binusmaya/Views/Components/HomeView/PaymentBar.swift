//
//  PaymentBar.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

protocol PaymentBarProtocol {
    
}

class PaymentBar: PaymentBarProtocol {
    private let financialRepository: FinancialRepository
    
    init () {
        self.financialRepository = FinancialRepository()
    }
    
    func render () -> ASLayoutSpec {
        let paymentBarIcon = ASImageNode()
        paymentBarIcon.image = UIImage(named: "mock-profile")
        
        let paymentBarHeader = ASStackLayoutSpec()
        paymentBarHeader.direction = .horizontal
        
        paymentBarHeader.children = [
            self.paymentBarTitle()
        ]
        
        let paymentBarCellContentWrapper = ASStackLayoutSpec()
        paymentBarCellContentWrapper.direction = .vertical
        paymentBarCellContentWrapper.spacing = 10
        paymentBarCellContentWrapper.children = self.paymentBarCellContentWrapperChildren()
        
        let paymentBarWrapper = ASStackLayoutSpec()
        paymentBarWrapper.direction = .vertical
        paymentBarWrapper.spacing = 10
        paymentBarWrapper.children = [
            paymentBarHeader,
            paymentBarCellContentWrapper,
        ]
        
        let paymentBarWrapperInset = ASInsetLayoutSpec()
        paymentBarWrapperInset.insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        paymentBarWrapperInset.child = paymentBarWrapper
        
        return paymentBarWrapperInset
    }
    
    func noUpcomingPayments () -> ASTextNode {
        let noUpcomingPaymentTextNode = ASTextNode()
        let noUpcomingPaymentTextNodeAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Fonts.smallFont,
            NSAttributedString.Key.foregroundColor : Colors.secondaryColor
        ]
        noUpcomingPaymentTextNode.attributedText = NSAttributedString(
            string: "No upcoming payments",
            attributes: noUpcomingPaymentTextNodeAttribute
        )
        
        return noUpcomingPaymentTextNode
    }
    
    func paymentBarCellContentWrapperChildren () -> [ASLayoutElement] {
        let upcomingFinancials = self.financialRepository.getUpcomingFinancials()
        
        if upcomingFinancials.isEmpty {
            return [ self.noUpcomingPayments() ]
        }
        
        return upcomingFinancials.map { financial -> ASLayoutSpec in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            
            let appliedAmountInt = Double(financial.applied_amt)
            let appliedAmountNSNumber = NSNumber(value: appliedAmountInt!)

            let formattedAmount = numberFormatter.string(from: appliedAmountNSNumber)
            
            return self.paymentBarCellContent(
                amountStr: formattedAmount!,
                deadlineStr: financial.due_dt
            )
        }
    }
    
    func paymentBarCellContent (
        amountStr: String,
        deadlineStr: String
    ) -> ASLayoutSpec {
        let paymentBarCellContent = ASStackLayoutSpec()
        paymentBarCellContent.direction = .horizontal
        paymentBarCellContent.alignItems = .end
        paymentBarCellContent.spacing = 5
        
        paymentBarCellContent.children = [
            self.amount(amountStr),
            self.deadline(deadlineStr)
        ]
        
        return paymentBarCellContent
    }
    
    func paymentBarTitle () -> ASTextNode {
        let paymentBarTitle = ASTextNode()
        let paymentBarTitleAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Colors.primaryColor,
            NSAttributedString.Key.font: Fonts.headerFont
        ]
        paymentBarTitle.attributedText = NSAttributedString(
            string: "Pembayaran",
            attributes: paymentBarTitleAttribute
        )
        
        return paymentBarTitle
    }
    
    func amount (_ amount: String) -> ASTextNode {
        let paymentBarCellContentAmount = ASTextNode()
        let paymentBarCellContentAmountAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Fonts.headerFont,
        ]
        paymentBarCellContentAmount.attributedText = NSAttributedString(
            string: amount,
            attributes: paymentBarCellContentAmountAttribute
        )
        
        return paymentBarCellContentAmount
    }
    
    func deadline (_ deadline: String) -> ASTextNode {
        let paymentBarCellContentDeadline = ASTextNode()
        let paymentBarCellContentDeadlineAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Fonts.smallFont,
            NSAttributedString.Key.foregroundColor : Colors.secondaryColor
        ]
               
        paymentBarCellContentDeadline.attributedText = NSAttributedString(
            string: deadline[0...9],
            attributes: paymentBarCellContentDeadlineAttribute
        )
        
        return paymentBarCellContentDeadline
    }
}

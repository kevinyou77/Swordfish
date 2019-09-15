//
//  HomeViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 26/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI () {
        let origin = CGPoint(x: 0, y: Screen.safeAreaTop)
        let size = CGSize(width: Screen.width, height: Screen.height)
        
        let scrollNode = ASScrollNode()
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.frame = CGRect(origin: origin, size: size)

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
        scrollNodeWrapper.style.width = ASDimensionMakeWithPoints(Screen.width)
        scrollNodeWrapper.style.height = ASDimensionMakeWithPoints(Screen.height)
        
        scrollNodeWrapper.children = [
            self.profileBar(),
            self.scheduleBar(),
            self.paymentBar()
        ]
        
        return scrollNodeWrapper
    }
    
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
    
    // MARK: PROFILE BAR
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
    
    // MARK: Schedule bar
    
    func scheduleBarHeader() -> ASLayoutSpec {
        let scheduleBarHeaderIcon = ASImageNode()
        
        let scheduleBarHeaderTextNode = ASTextNode()
        let scheduleBarHeaderTextNodeAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: Fonts.headerFont,
            NSAttributedString.Key.foregroundColor: Colors.primaryColor
        ]
        scheduleBarHeaderTextNode.attributedText = NSAttributedString(
            string: "4 kelas",
            attributes: scheduleBarHeaderTextNodeAttribute
        )
        
        let scheduleHeaderStackNode = ASStackLayoutSpec()
        scheduleHeaderStackNode.direction = .horizontal
        scheduleHeaderStackNode.justifyContent = .start
        
        scheduleHeaderStackNode.children = [
            scheduleBarHeaderIcon,
            scheduleBarHeaderTextNode
        ]
        
        return scheduleHeaderStackNode
    }
    
    func scheduleBarDate () -> ASTextNode {
        let dateTextNode = ASTextNode()
        let dateTextNodeAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 18)!
        ]
        dateTextNode.attributedText = NSAttributedString(
            string: "18:20",
            attributes: dateTextNodeAttribute
        )
        
        return dateTextNode
    }
    
    func scheduleBarCell () -> ASLayoutSpec {
        let scheduleBarCellCourseTitle = ASTextNode()
        let scheduleBarCellCourseTitleAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 18)!
        ]
        scheduleBarCellCourseTitle.attributedText = NSAttributedString(
            string: "Human Computer Interaction",
            attributes: scheduleBarCellCourseTitleAttribute
        )
        
        let scheduleBarCellCourseLocation = ASTextNode()
        let scheduleBarCellCourseLocationAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 12)!
        ]
        scheduleBarCellCourseLocation.attributedText = NSAttributedString(
            string: "ANGGREK",
            attributes: scheduleBarCellCourseLocationAttribute
        )
        
        let scheduleBarCellCourseRoom = ASTextNode()
        let scheduleBarCellCourseRoomAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 12)!
        ]
        scheduleBarCellCourseRoom.attributedText = NSAttributedString(
            string: "FA99",
            attributes: scheduleBarCellCourseRoomAttribute
        )
        
        let scheduleBarCellContent = ASStackLayoutSpec()
        scheduleBarCellContent.style.maxWidth = ASDimensionMakeWithPoints(Screen.width)
        scheduleBarCellContent.direction = .vertical
        scheduleBarCellContent.alignItems = .start
        scheduleBarCellContent.style.maxWidth = ASDimensionMakeWithPoints(Screen.width)
        
        let scheduleBarCellContentBottomStackView = ASStackLayoutSpec()
        scheduleBarCellContentBottomStackView.direction = .horizontal
        scheduleBarCellContentBottomStackView.spacing = 10
        
        scheduleBarCellContentBottomStackView.children = [
            scheduleBarCellCourseLocation,
            scheduleBarCellCourseRoom
        ]
        
        scheduleBarCellContent.children = [
            scheduleBarCellCourseTitle,
            scheduleBarCellContentBottomStackView
        ]
        
        let scheduleBarCellWrapper = ASStackLayoutSpec()
        scheduleBarCellWrapper.direction = .horizontal
        scheduleBarCellWrapper.alignItems = .center
        scheduleBarCellWrapper.spacing = 10
        
        scheduleBarCellWrapper.children = [
            self.scheduleBarDate(),
            scheduleBarCellContent,
        ]
        
        return scheduleBarCellWrapper
    }
    
    func scheduleBarContent () -> ASLayoutSpec {
        let schedulesStackNode = ASStackLayoutSpec()
        schedulesStackNode.direction = .vertical
        schedulesStackNode.spacing = 6
        
        schedulesStackNode.children = [
            self.scheduleBarCell()
        ]
        
        return schedulesStackNode
    }
    
    func scheduleBar () -> ASLayoutSpec {
        let schedulesStackNode = self.scheduleBarContent()
        // schedulebarcontent should receive a dictionary, loops in schedulebarcontent
        
        schedulesStackNode.children = [
            self.scheduleBarHeader(),
            self.scheduleBarContent()
        ]
        
        let scheduleBarInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let scheduleBarWrapper = ASInsetLayoutSpec(insets: scheduleBarInset, child: schedulesStackNode)
        
        return scheduleBarWrapper
    }
    
}

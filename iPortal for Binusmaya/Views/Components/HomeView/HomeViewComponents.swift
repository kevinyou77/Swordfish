//
//  HomeView.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/10/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import AsyncDisplayKit

protocol HomeViewComponentsProtocol {
    func getTaskBar () -> ASLayoutSpec
    func getGradeBar () -> ASLayoutSpec
    func getPaymentBar () -> ASLayoutSpec
    func getScheduleBar () -> ASLayoutSpec
    func getProfileBar () -> ASLayoutSpec
}

class HomeViewComponents: HomeViewComponentsProtocol {
    func getTaskBar () -> ASLayoutSpec {
        return taskBar()
    }
    
    func getGradeBar () -> ASLayoutSpec {
        return gradeBar()
    }
    
    func getPaymentBar () -> ASLayoutSpec {
        return paymentBar()
    }
    
    func getScheduleBar () -> ASLayoutSpec {
        return scheduleBar()
    }
    
    func getProfileBar () -> ASLayoutSpec {
        return profileBar()
    }
}

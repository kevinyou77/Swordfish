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
    private var schedulesBar: SchedulesBar
    private var profileBar: ProfileBar
    private var scoreInformationBar: ScoreInformationBar
    private var paymentBar: PaymentBar
    
    init () {
        self.schedulesBar = SchedulesBar()
        self.profileBar = ProfileBar()
        self.scoreInformationBar = ScoreInformationBar()
        self.paymentBar = PaymentBar()
    }
    
    func getTaskBar () -> ASLayoutSpec {
        return taskBar()
    }
    
    func getGradeBar () -> ASLayoutSpec {
        return gradeBar()
    }
    
    func getPaymentBar () -> ASLayoutSpec {
        return self.paymentBar.render()
    }
    
    func getScheduleBar () -> ASLayoutSpec {
        return self.schedulesBar.render()
    }
    
    func getProfileBar () -> ASLayoutSpec {
        return self.profileBar.render()
    }
    
    func getScoreInformationBar () -> ASLayoutSpec {
        return self.scoreInformationBar.render()
    }
}

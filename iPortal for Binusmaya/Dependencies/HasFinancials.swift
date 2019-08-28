//
//  HasGrade.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol HasFinancials {
    var financialInteractor: FinancialInteractor { get }
}

extension HasFinancials {
    var financialInteractor: FinancialInteractor {
        return FinancialInteractor()
    }
}

//
//  FinancialsViewModelDependencies.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

struct FinancialsViewModelDependencies : HasAuth, HasFinancials {
    let authInteractor: AuthInteractor
    let financialInteractor: FinancialInteractor
    
    init(
        authInteractor: AuthInteractor = AuthInteractor(),
        financialInteractor: FinancialInteractor = FinancialInteractor()
    ) {
        self.authInteractor = authInteractor
        self.financialInteractor = financialInteractor
    }
}

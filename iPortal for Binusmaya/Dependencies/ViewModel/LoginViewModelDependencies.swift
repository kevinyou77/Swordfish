//
//  FinancialsViewModelDependencies.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

struct LoginViewModelDependencies : HasAuth, HasFinancials, HasGrade, HasTerm, HasCourse {
    let authInteractor: AuthInteractor
    let financialInteractor: FinancialInteractor
    let scheduleInteractor: CourseInteractor
    let gradeInteractor: GradeInteractor
    let termInteractor: TermInteractor
    
    init(
        authInteractor: AuthInteractor = AuthInteractor(),
        financialInteractor: FinancialInteractor = FinancialInteractor(),
        termInteractor: TermInteractor = TermInteractor(),
        gradeInteractor: GradeInteractor = GradeInteractor(),
        scheduleInteractor: CourseInteractor = CourseInteractor()
    ) {
        self.authInteractor = authInteractor
        self.financialInteractor = financialInteractor
        self.termInteractor = termInteractor
        self.gradeInteractor = gradeInteractor
        self.scheduleInteractor = scheduleInteractor
    }
}

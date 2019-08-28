//
//  GPAViewModelDependencies.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

struct GPAViewModelDependencies : HasAuth, HasGrade, HasTerm {
    let authInteractor: AuthInteractor
    let termInteractor: TermInteractor
    let gradeInteractor: GradeInteractor
    
    init (
        authInteractor: AuthInteractor = AuthInteractor(),
        termInteractor: TermInteractor = TermInteractor(),
        gradeInteractor: GradeInteractor = GradeInteractor()
    ) {
        self.authInteractor = authInteractor
        self.termInteractor = termInteractor
        self.gradeInteractor = gradeInteractor
    }
}

//
//  Dependency.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 24/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol Dependency {
    func resolveBimayApi () -> BimayApiProtocol
    
    func resolveAuthInteractor () -> AuthInteractor
    func resolveGradeInteractor () -> GradeInteractor
    func resolveCourseInteractor () -> CourseInteractor
    func resolveTermInteractor () -> TermInteractor
    func resolveFinancialInteractor () -> FinancialInteractor
    
    func resolveUserRepository() -> UserRepository
    func resolveScheduleRepository() -> ScheduleRepository
    func resolveGradeRepository() -> GradeRepository
    func resolveFinancialRepository() -> FinancialRepository
    func resolveTermRepository() -> TermRepository
}

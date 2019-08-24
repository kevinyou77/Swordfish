//
//  CoreDependency.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 24/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

open class CoreDependencies: Dependency {
    public func resolveAuthInteractor() -> AuthInteractor {
        return AuthInteractor(
            userRepository: resolveUserRepository()
        )
    }
    
    public func resolveGradeInteractor() -> GradeInteractor {
        return GradeInteractor(
            gradeRepository: resolveGradeRepository(),
            termRepository: resolveTermRepository(),
            userRepository: resolveUserRepository()
        )
    }
    
    public func resolveCourseInteractor() -> CourseInteractor {
        return CourseInteractor(
            scheduleRepository: resolveScheduleRepository(),
            termRepository: resolveTermRepository()
        )
    }
    
    public func resolveTermInteractor() -> TermInteractor {
        return TermInteractor(
            termRepository: resolveTermRepository()
        )
    }
    
    public func resolveFinancialInteractor() -> FinancialInteractor {
        return FinancialInteractor(
            financialRepository: resolveFinancialRepository()
        )
    }
    
    public func resolveUserRepository() -> UserRepository {
        return UserRepository()
    }
    
    public func resolveScheduleRepository() -> ScheduleRepository {
        return ScheduleRepository()
    }
    
    public func resolveGradeRepository() -> GradeRepository {
        return GradeRepository()
    }
    
    public func resolveFinancialRepository() -> FinancialRepository {
        return FinancialRepository()
    }
    
    public func resolveTermRepository() -> TermRepository {
        return TermRepository()
    }
    
    public func resolveBimayApi() -> BimayApiProtocol {
        return BimayApi()
    }
    
}

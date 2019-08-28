//
//  SchedulesViewModelDependencies.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

struct SchedulesViewModelDependencies: HasAuth, HasCourse {
    let authInteractor: AuthInteractor
    let courseInteractor: CourseInteractor
    let courseRepository: ScheduleRepository
    
    init (
        authInteractor: AuthInteractor = AuthInteractor(),
        courseInteractor: CourseInteractor = CourseInteractor(),
        courseRepository: ScheduleRepository = ScheduleRepository()
    ) {
        self.authInteractor = authInteractor
        self.courseInteractor = courseInteractor
        self.courseRepository = courseRepository
    }
}

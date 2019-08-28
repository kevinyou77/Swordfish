//
//  HasSchedules.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol HasCourse {
    var scheduleInteractor: CourseInteractor { get }
}

extension HasCourse {
    var scheduleInteractor: CourseInteractor {
        return CourseInteractor()
    }
}

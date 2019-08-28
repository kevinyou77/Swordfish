//
//  HasGrade.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol HasGrade {
    var gradeInteractor: GradeInteractor { get }
}

extension HasGrade {
    var gradeInteractor: GradeInteractor {
        return GradeInteractor()
    }
}

//
//  CourseModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class APIGradeModel : Decodable {
    @objc dynamic var score: [GradeModel]?
    @objc dynamic var credit: CreditModel?
    @objc dynamic var strm: String
}

class GradeModel : Object, Decodable {
    @objc dynamic var course: String
    @objc dynamic var scu: Int
    @objc dynamic var course_grade: String
    @objc dynamic var grade: String
    @objc dynamic var kodemtk: String
    @objc dynamic var lam: String
    @objc dynamic var weight: String
    dynamic var score: StringOrInt?
    
    enum CodingKeys: String, CodingKey {
        case course, scu, course_grade, grade, kodemtk, lam, score, weight
    }

}

class Grades : Object {
    @objc dynamic var lam: String = ""
    @objc dynamic var grade: String = ""
}

class CourseGradeModel : Object {
    @objc dynamic var courseTitle: String = ""
    @objc dynamic var courseCode: String = ""
    @objc dynamic var strm: String = ""
    @objc dynamic var course_grade: String = ""
    @objc dynamic var scu: String = ""
    @objc dynamic var credit: Int = 0
    @objc dynamic var GPA_CUM: String = ""
    @objc dynamic var GPA_CUR: String = ""
    dynamic var grades: List<Grades> = List<Grades>()
}

class CreditModel : Object, Decodable {
    @objc dynamic var GPA_CUM: String
    @objc dynamic var GPA_CUR: String
    @objc dynamic var SCU_CUR: Int
}

//
//  CourseModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift

class CourseModel : Object, Decodable {
    @objc dynamic var CAMPUS: String
    @objc dynamic var CLASS_SECTION: String
    @objc dynamic var COURSE_TITLE_LONG: String
    @objc dynamic var LOCATION: String
    @objc dynamic var START_DT: String
    @objc dynamic var SSR_COMPONENT: String
    @objc dynamic var CalendarColor: String
    @objc dynamic var N_DELIVERY_MODE: String
    @objc dynamic var MEETING_TIME_START: String
    @objc dynamic var MEETING_TIME_END: String
    @objc dynamic var ROOM: String
}

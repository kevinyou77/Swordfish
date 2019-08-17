//
//  CourseModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift

class FinancialModel : Object, Decodable {
    @objc dynamic var Status: String
    @objc dynamic var applied_amt: String
    @objc dynamic var item_amt: String
    @objc dynamic var descr: String
    @objc dynamic var due_dt: String
    @objc dynamic var item_term: String
}

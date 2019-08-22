//
//  TermModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift

class TermModel : Object, Decodable {
    @objc dynamic var career: String
    @objc dynamic var emplid: String
    @objc dynamic var field: String
    @objc dynamic var value: String
    @objc dynamic var institution: String
}

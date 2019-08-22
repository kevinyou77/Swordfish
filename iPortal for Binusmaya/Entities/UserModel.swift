//
//  UserModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 29/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel : Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var cookie: String = ""
}

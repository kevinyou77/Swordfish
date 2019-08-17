//
//  UserModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 29/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import ObjectMapper

private let USERNAME = "username"
private let PASSWORD = "password"

class UserModel : Mappable {
    internal var username: String?
    internal var password: String?
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        username <- map[USERNAME]
        password <- map[PASSWORD]
    }
}

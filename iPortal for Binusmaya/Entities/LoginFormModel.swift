//
//  LoginFormModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 30/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

class LoginFormModel : Codable {
    internal var username : [String: String] = [:]
    internal var password : [String: String] = [:]
    internal var login : [String: String] = [:]
    internal var hiddenFields : [String: String] = [:]
}

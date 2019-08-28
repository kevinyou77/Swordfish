//
//  HasAuth.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol HasAuth {
    var authInteractor: AuthInteractor { get }
}

extension HasAuth {
    var authInteractor: AuthInteractor {
        return AuthInteractor()
    }
}

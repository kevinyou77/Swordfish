//
//  HasTerm.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

public protocol HasTerm {
    var termInteractor: TermInteractor { get }
}

extension HasTerm {
    var termInteractor: TermInteractor {
        return TermInteractor()
    }
}

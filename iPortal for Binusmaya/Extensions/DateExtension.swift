//
//  DateExtension.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 11/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

extension Date {
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

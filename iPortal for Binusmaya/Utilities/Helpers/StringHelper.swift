//
//  ApiHelper.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 30/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

class StringHelper {
    static func getValueFromRegex (from string: String, with pattern: String) -> [String]? {
        do {
            let regexFromPattern = try NSRegularExpression(pattern: pattern)
            
            let findMatchFromRegex = regexFromPattern.matches(
                in: string,
                range: NSRange(string.startIndex..., in: string)
            )
            
            let result = findMatchFromRegex.map { (element) -> String in
                let range = Range(element.range, in: string)!
                let extracted = string[range]
                return String(extracted)
            }
            
            return result
        } catch {
            print("fail to parse string")
            return nil
        }
    }
}

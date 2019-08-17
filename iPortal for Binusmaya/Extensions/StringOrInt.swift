//
//  StringOrInt.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 13/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation

enum StringOrInt : Codable {
    case string(String), integer(Int)
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case .string(let str):
            var container = encoder.singleValueContainer()
            try container.encode(str)
        case .integer(let int):
            var container = encoder.singleValueContainer()
            try container.encode(int)
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let str = try container.decode(String.self)
            self = StringOrInt.string(str)
        }
        catch {
            do { let container = try decoder.singleValueContainer()
                let int = try container.decode(Int.self)
                self = StringOrInt.integer(int)
            }
            catch {
                throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected to decode an Int or a String"))
            }
        }
    }
}

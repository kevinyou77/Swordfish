//
//  iPortal_for_BinusmayaTests.swift
//  iPortal for BinusmayaTests
//
//  Created by Kevin Yulias on 27/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import XCTest
@testable import iPortal_for_BinusmayaUITests

class iPortal_for_BinusmayaTests: XCTestCase {

    func testHelloWorld () {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }

}

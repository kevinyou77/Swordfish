//
//  BimayApiProtocol.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 30/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import SwiftSoup
import RxSwift

public protocol BimayApiProtocol {
    static func getIndexHtml () -> Observable<String>
    static func getSerial(from document: Document) -> String?
    static func getIndexHtmlTokens(from htmlString: String) -> [String: String]?
    static func getLoaderJs(withSerial serial: String?, cookies: String) -> Observable<String>
    static func getHiddenFieldsFromLoaderJs (from htmlString: String) -> [String: [String: String]]?
    static func constructCookies(_ phpSessId: String, _ sidBinusLogin: String) -> String
    static func login(withCookie cookie: String, withFromData formData: [String:String]) -> Observable<String>
    static func getAllSchedules(withCookie cookie: String) -> Observable<Data>
}

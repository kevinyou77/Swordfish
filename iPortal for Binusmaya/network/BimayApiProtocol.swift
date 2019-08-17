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

protocol BimayApiProtocol {
    func getIndexHtml () -> Observable<String>
    func getSerial(from document: Document) -> String?
    func getIndexHtmlTokens(from htmlString: String) -> [String: String]?
    func getLoaderJs(withSerial serial: String?, cookies: String) -> Observable<String>
    func getHiddenFieldsFromLoaderJs (from htmlString: String) -> [String: [String: String]]?
    func constructCookies(_ phpSessId: String, _ sidBinusLogin: String) -> String
    func login(withCookie cookie: String, withFromData formData: [String:String]) -> Observable<String?>
    func getAllSchedules(withCookie cookie: String) -> Observable<String>
}

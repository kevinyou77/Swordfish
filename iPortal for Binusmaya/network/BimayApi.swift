//
//  BimayApi.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 30/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import SwiftSoup
import RxSwift
import RxCocoa
import Alamofire

struct Endpoints {
    var baseUrl: URL? { return URL(string: "https://binusmaya.binus.ac.id") }
    var login: URL? { return URL(string: "\(baseUrl!)/login") }
    var sys_login: URL? { return URL(string: "\(login!)/sys_login.php") }
    var getAllSchedules: URL? {
        return URL(string: "\(baseUrl!)/services/ci/index.php/student/class_schedule/classScheduleGetStudentClassSchedule")
    }
    
    var getStudentPeriods: URL? {
        return URL(string: "\(baseUrl!)/services/ci/index.php/scoring/ViewGrade/getPeriodByBinusianId")
    }
    
    func getLoaderPhp (withSerial serial: String) -> URL? {
        return URL(string: "https://binusmaya.binus.ac.id/login/loader.php?serial=\(serial)")
    }
    
    func getStudentGrade (by term: String) -> URL? {
        return URL(string: "https://binusmaya.binus.ac.id/services/ci/index.php/scoring/ViewGrade/getStudentScore/\(term)")
    }
    
    var getFinancialSummary: URL? {
        return URL(string: "https://binusmaya.binus.ac.id/services/ci/index.php/financial/getFinancialSummary")
    }
}

class BimayApi {
    static let endpoints = Endpoints()

    static func getIndexHtml() -> Observable<String> {
        return Observable<String>.create { observer in
            let task = URLSession.shared.dataTask(with: self.endpoints.login!) { (data, _, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                let indexHtmlString = String(data: data!, encoding: .utf8)
                observer.onNext(indexHtmlString!)
                observer.on(.completed)
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    static func getSerial(from document: Document) -> String? {
        do {
            let getJsScripts = try document.select("script").outerHtml()
            let parsedJsScripts = try SwiftSoup.parse(getJsScripts)
            let findScriptTagInParsedJsScripts  = try parsedJsScripts.select("script[src*='php']")
            let serialScriptTag = try findScriptTagInParsedJsScripts.first()!.outerHtml()
            let splitSerialScriptTag = serialScriptTag.components(separatedBy: "serial=")
            
            return splitSerialScriptTag[1].components(separatedBy: "\"")[0]
        } catch {
            print("get serial error")
            return nil
        }
    }
    
    static func getIndexHtmlTokens(from htmlString: String) -> [String: String]? {
        do {
            let doc = try SwiftSoup.parse(htmlString)
            let usernameInput = try doc.select("input[type=text]").first()!
            let usernameInputName = try usernameInput.attr("name")
                
            let passwordInput = try doc.select("input[type=password]").first()!
            let passwordInputName = try passwordInput.attr("name")
                
            let submitInput = try doc.select("input[type=submit]").first()!
            let submitInputName = try submitInput.attr("name")
                
            guard let serial = self.getSerial(from: doc) else { return nil }
            
            let data = [
                "usernameInputFormName": usernameInputName,
                "passwordInputFormName": passwordInputName,
                "submitInputName": submitInputName,
                "serial": serial
            ]
            
            return data
        } catch {
            print("error")
            return nil
        }
    }

    static func getLoaderJs(withSerial serial: String?, cookies: String) -> Observable<String> {
        let loaderPhp = endpoints.getLoaderPhp(withSerial: serial!)!
        
        var request = URLRequest(url: loaderPhp)
        request.setValue("https://binusmaya.binus.ac.id/login/", forHTTPHeaderField: "Referer")
        request.setValue(cookies, forHTTPHeaderField: "Cookie")
        request.setValue(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            forHTTPHeaderField: "User-Agent"
        )
        
        return Observable<String>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                }
                
                let loaderJs = String(data: data!, encoding: .utf8)!
                observers.onNext(loaderJs)
                observers.on(.completed)
            }
            
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    static func getHiddenFieldsFromLoaderJs (from htmlString: String) -> [String: [String: String]]? {
        let hiddenFieldNamePattern = "name=\"([^\"]*)\""
        let hiddenFieldValuesPattern = "value=\"([^\"]*)\""
        
        let hiddenFieldNames = StringHelper.getValueFromRegex(from: htmlString, with: hiddenFieldNamePattern)
        let hiddenFieldValues = StringHelper.getValueFromRegex(from: htmlString, with: hiddenFieldValuesPattern)
        
        guard let fieldNames = hiddenFieldNames else { return nil }
        guard let fieldValues = hiddenFieldValues else { return nil }
        
        let names = fieldNames.map { item -> String in
            let temp =  item.replacingOccurrences(of: "name=\"", with: "")
            return temp.replacingOccurrences(of: "\"", with: "")
        }
        
        let values = fieldValues.map { item -> String in
            let temp = item.replacingOccurrences(of: "value=\"", with: "")
            return temp.replacingOccurrences(of: "\"", with: "")
        }
        
        let hiddenFieldNameAndValues = [
            "extraFields1": [names[0]: values[0]],
            "extraFields2": [names[1]: values[1]]
        ]

        return hiddenFieldNameAndValues
    }
    
    static func constructCookies(_ phpSessId: String, _ sidBinusLogin: String) -> String {
        return "PHPSESSID=\(phpSessId); _SID_BinusLogin_=\(sidBinusLogin)"
    }
    
    static func login(withCookie cookie: String, withFromData formData: [String:String]) -> Observable<String> {
        let url = self.endpoints.sys_login!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(cookie, forHTTPHeaderField: "Cookie")
        request.setValue("https://binusmaya.binus.ac.id/", forHTTPHeaderField: "Origin")
        request.setValue("https://binusmaya.binus.ac.id/login/", forHTTPHeaderField: "Referer")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            forHTTPHeaderField: "User-Agent"
        )

        let bodyString = (formData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        
        request.httpBody = bodyString.data(using: .utf8)
        
        return Observable<String>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                    return
                }
                
                let urlResponseString = response?.url?.absoluteString
                observers.onNext(urlResponseString!)
                observers.on(.completed)
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    static func getAllSchedules(withCookie cookie: String) -> Observable<Data> {
        let url = self.endpoints.getAllSchedules!
        
        var request = URLRequest(url: url)
        request.setValue(cookie, forHTTPHeaderField: "Cookie")
        request.setValue("https://binusmaya.binus.ac.id/newStudent/index.html", forHTTPHeaderField: "Referer")
        request.setValue(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            forHTTPHeaderField: "User-Agent"
        )
        
        return Observable<Data>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                    return
                }
                
                observers.onNext(data!)
                observers.on(.completed)
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    static func getStudentPeriods(withCookie cookie: String) -> Observable<Data> {
        let url = self.endpoints.getStudentPeriods!
        
        var request = URLRequest(url: url)
        request.setValue(cookie, forHTTPHeaderField: "Cookie")
        request.setValue("https://binusmaya.binus.ac.id/newStudent/index.html", forHTTPHeaderField: "Referer")
        request.setValue(
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            forHTTPHeaderField: "User-Agent"
        )
        
        return Observable<Data>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                    return
                }
                
                observers.onNext(data!)
                observers.on(.completed)
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    static func getStudentGrade (by term: String, with cookie: String) -> Observable<Data> {
        let url = self.endpoints.getStudentGrade(by: term)!
        let params = [
            "Referer": "https://binusmaya.binus.ac.id/newStudent/",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            "Cookie": cookie
        ]

        return RxHelper.request(to: url, with: params) { (observers, data) in
            observers.onNext(data)
            observers.onCompleted()
        }
    }
    
    static func getFinancialSummary (with cookie: String) -> Observable<Data> {
        let url = self.endpoints.getFinancialSummary!
        let params = [
            "Referer": "https://binusmaya.binus.ac.id/newStudent/",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            "Cookie": cookie
        ]
        
        return RxHelper.request(to: url, with: params) { (observers, data) in
            observers.onNext(data)
            observers.onCompleted()
        }
    }
}

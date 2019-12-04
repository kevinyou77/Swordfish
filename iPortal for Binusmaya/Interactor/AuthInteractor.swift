//
//  AuthInteractor.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 29/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import SwiftSoup
import Realm
import RealmSwift
import RxSwift
import RxCocoa

public class AuthInteractor {
    let userRepository: UserRepository
    
    init (
        userRepository: UserRepository = UserRepository()
    ) {
        self.userRepository = userRepository
    }

    func constructLoginFormModel(username: String, password: String) -> Observable<Bool> {
        var formData = [String:String]()
        var phpSessId = ""
        var sidBinusLogin = ""
        var cookies = ""
        
        return BimayApi.getIndexHtml().flatMap { res -> Observable<[String: String]> in
            return Observable<[String:String]>.create { observers in
                observers.onNext(BimayApi.getIndexHtmlTokens(from: res)!)
                return Disposables.create()
            }
        }
        .flatMap { tokens -> Observable<String> in
            guard let serial = tokens["serial"] else { return Observable.empty() }
            
            phpSessId = (HTTPCookieStorage.shared.cookies?.first { $0.name == "PHPSESSID" }!.value)!
            sidBinusLogin = (HTTPCookieStorage.shared.cookies?.first{ $0.name == "_SID_BinusLogin_" })!.value
            
            cookies = BimayApi.constructCookies(phpSessId, sidBinusLogin)
            
            formData[tokens["usernameInputFormName"]!] = username
            formData[tokens["passwordInputFormName"]!] = password
            formData[tokens["submitInputName"]!] = "Login"
            
            return BimayApi.getLoaderJs(withSerial: serial, cookies: cookies)
        }
        .flatMap { data -> Observable<String> in
            let hiddenFields = BimayApi.getHiddenFieldsFromLoaderJs(from: data)!

            let field1Key = Array(hiddenFields["extraFields1"]!.keys)[0]
            let field2Key = Array(hiddenFields["extraFields2"]!.keys)[0]
            let field1Values = Array(hiddenFields["extraFields1"]!.values)[0]
            let field2Values = Array(hiddenFields["extraFields2"]!.values)[0]

            formData[field1Key] = field1Values
            formData[field2Key] = field2Values
            
            return BimayApi.login(withCookie: cookies, withFromData: formData)
        }
        .flatMap { data -> Observable<Bool> in
            let user = UserModel()
            user.username = username
            user.password = password
            user.cookie = cookies
            
            self.userRepository.saveUserCredentials(user: user)
            
            return Observable<Bool>.create { observers in
                observers.onNext(true)
                observers.on(.completed)
                
                return Disposables.create()
            }
        }
    }
    
    func getUserCredentials () -> UserModel {
        return self.userRepository.getUserCredentials()
    }
}

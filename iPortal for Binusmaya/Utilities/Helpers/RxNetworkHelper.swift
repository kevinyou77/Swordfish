//
//  RxHelper.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 08/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RxNetworkHelper {
    static func get<T> (
        to url: URL,
        with params: [String : String],
        afterDataReceived: @escaping (AnyObserver<T>, Data) -> ()
    ) -> Observable<T> {
        var request = URLRequest(url: url)
        
        for (key, value) in params {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return Observable<T>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                }
                
                afterDataReceived(observers, data!)
            }
            
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    static func post<T> (
        to url: URL,
        with params: [String : String],
        requestBody: Data,
        afterDataReceived: @escaping (AnyObserver<T>, Data) -> ()
    ) -> Observable<T> {
        var request = URLRequest(url: url)
        
        for (key, value) in params {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = requestBody
        
        return Observable<T>.create { observers in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observers.onError(error)
                }
                
                afterDataReceived(observers, data!)
            }
            
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}

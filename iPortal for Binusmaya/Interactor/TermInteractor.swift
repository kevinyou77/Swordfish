//
//  PeriodInteractor.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Realm
import RealmSwift

class TermInteractor {
    let termRepository: TermRepository
    
    init (
        termRepository: TermRepository = TermRepository()
    ) {
        self.termRepository = termRepository
    }
    
    func getCurrentTerm (withCookie cookie: String) -> Observable<[TermModel]> {
        return BimayApi.getStudentPeriods(withCookie: cookie).flatMap { [weak self] event -> Observable<[TermModel]> in
            guard let self = self else { return Observable.empty() }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([TermModel].self, from: event)
                
                self.termRepository.saveTerm(terms: model)
                
                return Observable<[TermModel]>.create { observers in
                    observers.onNext(model)
                    observers.onCompleted()
                    
                    return Disposables.create()
                }
            } catch {
                print("invalid")
                return Observable.empty()
            }
        }
    }
}

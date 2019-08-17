//
//  FinancialsInteractor.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 14/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class FinancialInteractor {
    let financialRepository: FinancialRepository
    
    init () {
        self.financialRepository = FinancialRepository()
    }
    
    func getAllFinancials (withCookie cookie: String) -> Observable<[FinancialModel]> {
        return BimayApi.getFinancialSummary(with: cookie)
            .flatMapLatest { [weak self] event -> Observable<[FinancialModel]> in
                guard let self = self else { return Observable.empty() }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([FinancialModel].self, from: event)
                    
                    return Observable<[FinancialModel]>.create { [weak self] observers in
                        guard let self = self else { return Disposables.create() }

                        self.financialRepository.saveFinancials(financial: model)
                        observers.onNext(model)
                        observers.on(.completed)
                        
                        return Disposables.create()
                    }
                } catch {
                    print("invalid")
                    return Observable.empty()
                }
            }
    }
    
    func getFinancials () -> [FinancialModel] {
        return self.financialRepository.getFinancials()
    }
}

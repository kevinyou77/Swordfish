//
//  FinancialsCellViewModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 14/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Realm
import RxDataSources

class FinancialsViewModel {
    typealias Dependencies = HasFinancials & HasAuth

    let financialInteractor: FinancialInteractor
    let authInteractor: AuthInteractor
    let disposeBag: DisposeBag
    var financialModels: BehaviorRelay<[FinancialModel]>
    
    init (
        dependencies: Dependencies
    ) {
        self.authInteractor = dependencies.authInteractor
        self.financialInteractor = dependencies.financialInteractor
        self.disposeBag = DisposeBag()
        self.financialModels = BehaviorRelay<[FinancialModel]>(value: [])
    }
    
    func getFinancials (onDataReceived: @escaping ([FinancialModel]) -> ()) {
        let fin = self.financialInteractor.getFinancials()
        onDataReceived(fin)
    }
    
    func sync (onDataReceived: @escaping ([FinancialModel]) -> ()) {
        let user = self.authInteractor.getUserCredentials()
        _ = self.authInteractor.constructLoginFormModel(username: user.username, password: user.password)
            .flatMap { [weak self] res -> Observable<[FinancialModel]> in
                guard let self = self else { return Observable.empty() }
                
                let newUser = self.authInteractor.getUserCredentials()
                return self.financialInteractor.getAllFinancials(withCookie: newUser.cookie)
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .utility))
            .subscribe(onNext: { res in
                self.getFinancials { model in
                    onDataReceived(model)
                }
            }, onCompleted: {
                print("hehe")
            })
            .disposed(by: self.disposeBag)
    }
}

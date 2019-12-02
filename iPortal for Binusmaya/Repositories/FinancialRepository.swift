//
//  ScheduleRepository.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

public class FinancialRepository {
    let disposeBag = DisposeBag()
    
    func saveFinancials (financial: [FinancialModel]) {
        let realm = try! Realm()
        let obj = realm.objects(FinancialModel.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: financial)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func deleteFinancials () {
        let realm = try! Realm()
        let obj = realm.objects(FinancialModel.self)
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
    }
    
    func getFinancials () -> [FinancialModel] {
        let realm = try! Realm()
        return realm.objects(FinancialModel.self)
                .sorted(byKeyPath: "due_dt", ascending: false)
                .toArray()
    }
    
    func getUpcomingFinancials () -> [FinancialModel] {
        let allFinancials = self.getFinancials()
        
        return allFinancials.filter { financial in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let date = dateFormatter.date(from: financial.due_dt[0...9])
            
            return date!.timeIntervalSince1970 > Date().timeIntervalSince1970
        }
    }
}

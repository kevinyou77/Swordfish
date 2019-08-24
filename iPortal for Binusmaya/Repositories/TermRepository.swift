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

public class TermRepository {
    let disposeBag = DisposeBag()
    
    func saveTerm (term: TermModel) {
        let realm = try! Realm()
        let obj = realm.objects(TermModel.self)
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: term)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func saveTerm (terms: [TermModel]) {
        let realm = try! Realm()
        let obj = realm.objects(TermModel.self)
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: terms)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func getTerms () -> [TermModel] {
        let realm = try! Realm()
        return Array(realm.objects(TermModel.self))
    }
}

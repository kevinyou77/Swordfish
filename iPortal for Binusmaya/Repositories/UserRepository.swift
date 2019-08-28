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

public class UserRepository {
    let disposeBag = DisposeBag()
    
    func saveUserCredentials (user: UserModel) {
        let realm = try! Realm()
        let obj = realm.objects(UserModel.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: user)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func deleteUserCredentials () {
        let realm = try! Realm()
        let obj = realm.objects(UserModel.self)
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
    }
    
    func getUserCredentials () -> UserModel {
        let realm = try! Realm()
        return realm.objects(UserModel.self).last!
    }
    
    func isUserExists () -> Bool {
        let realm = try! Realm()
        return realm.objects(UserModel.self).count != 0
    }
}

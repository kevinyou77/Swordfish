//
//  SchedulesViewModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 09/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Realm
import RxDataSources

class GPAViewModel {
    let gradeInteractor: GradeInteractor
    let termInteractor: TermInteractor
    let authInteractor: AuthInteractor
    let disposeBag: DisposeBag
    var gradeModels: BehaviorRelay<[SectionModel<String, CourseGradeModel>]>
    var culmulativeGPA: String
    
    init () {
        self.gradeInteractor = GradeInteractor()
        self.termInteractor = TermInteractor()
        self.authInteractor = AuthInteractor()
        self.disposeBag = DisposeBag()
        self.gradeModels =  BehaviorRelay<[SectionModel<String, CourseGradeModel>]>(value: [])
        self.culmulativeGPA = ""
    }
    
    func getGPA (onDataReceived: @escaping ([SectionModel<String, CourseGradeModel>]) -> ()) {
        let grades = self.gradeInteractor.getGradeSections()
        self.gradeModels.accept(grades)
        
        /*
            I thought sorting through realm again to get last GPA is a bit overkill
            So i just do this dangerous shit instead
        */
        
        let lastGPA = grades.first?.items.first?.GPA_CUM ?? "0.0"
        self.culmulativeGPA = lastGPA
        
        onDataReceived(grades)
    }
    
    func sync (onDataReceived: @escaping ([SectionModel<String, CourseGradeModel>]) -> ()) {
        let user = self.authInteractor.getUserCredentials()
        _ = self.authInteractor.constructLoginFormModel(username: user.username, password: user.password)
            .flatMap { [weak self] res -> Observable<[TermModel]> in
                guard let self = self else { return Observable.empty() }
                
                let newUser = self.authInteractor.getUserCredentials()
                return self.termInteractor.getCurrentTerm(withCookie: newUser.cookie)
            }
            .flatMap { [weak self] res -> Observable<[GradeModel]> in
                guard let self = self else { return Observable.empty() }
        
                return self.gradeInteractor.getAllGradesFromApi()
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { grades in
                self.getGPA { event in
                    onDataReceived(event)
                }
            })
            .disposed(by: self.disposeBag)
    }
}


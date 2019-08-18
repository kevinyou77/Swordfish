//
//  LoginViewModel.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 15/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class LoginViewModel {
    let financialInteractor: FinancialInteractor
    let authInteractor: AuthInteractor
    let courseInteractor: CourseInteractor
    let termInteractor: TermInteractor
    let gradeInteractor: GradeInteractor
    let disposeBag: DisposeBag
    var financialModels =  BehaviorRelay<[FinancialModel]>(value: [])
    
    var cookies: String
    
    init () {
        self.authInteractor = AuthInteractor()
        self.financialInteractor = FinancialInteractor()
        self.disposeBag = DisposeBag()
        self.courseInteractor = CourseInteractor()
        self.termInteractor = TermInteractor()
        self.gradeInteractor = GradeInteractor()
        self.cookies = ""
    }
    
    func getScheduleData (username: String, password: String) -> Observable<[SectionModel<String, CourseModel>]> {
        let user = UserModel()
        user.username = username
        user.password = password
        user.cookie = cookies
        
        return self.authInteractor.constructLoginFormModel(username: username, password: password)
            .flatMap { [weak self] res -> Observable<[CourseModel]> in
                guard let self = self else { return Observable.empty() }
                
                self.cookies = self.authInteractor.getUserCredentials().cookie
                return self.courseInteractor.getAllSchedules(withTerm: "1610", withCookie: self.cookies)
            }
            .flatMap { [weak self] schedules -> Observable<[SectionModel<String, CourseModel>]>  in
                guard let self = self else { return Observable.empty() }
                
                return Observable<[SectionModel<String, CourseModel>]>.create { observers in
                    let scheduleWithSections = self.courseInteractor.extractSectionsFromSchedules(with: schedules)
                    observers.onNext(scheduleWithSections)
                    observers.on(.completed)
                    
                    return Disposables.create()
                }
            }
    }
    
    func getFinancials () -> Observable<[FinancialModel]> {
        return self.financialInteractor.getAllFinancials(withCookie: self.cookies)
    }
    
    func getGPA () -> Observable<[GradeModel]> {
        return self.termInteractor.getCurrentTerm(withCookie: self.cookies)
            .flatMap { [weak self] res -> Observable<[GradeModel]> in
                guard let self = self else { return Observable.empty() }
                
                return self.gradeInteractor.getAllGradesFromApi()
            }
        
    }
    
    func getAllData (username: String, password: String) -> Observable<[GradeModel]> {
        return self.getScheduleData(username: username, password: password).flatMap { [weak self] schedules -> Observable<[FinancialModel]> in
            guard let self = self else { return Observable.empty() }
            
            return self.getFinancials()
        }
        .take(1)
        .flatMap { [weak self] gpa -> Observable<[GradeModel]> in
            guard let self = self else { return Observable.empty() }
            
            return self.getGPA()
        }
    }
}

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

class SchedulesViewModel {
    let authInteractor: AuthInteractor
    let courseInteractor: CourseInteractor
    let disposeBag: DisposeBag
    var courses: [SectionModel<String,CourseModel>]
    let courseRepository: ScheduleRepository
    
    init (
        authInteractor: AuthInteractor = AuthInteractor(),
        courseInteractor: CourseInteractor = CourseInteractor(),
        courses: [SectionModel<String, CourseModel>] = [SectionModel<String, CourseModel>](),
        courseRepository: ScheduleRepository = ScheduleRepository()
    ) {
        self.authInteractor = authInteractor
        self.courseInteractor = courseInteractor
        self.courses = courses
        self.courseRepository = courseRepository
        self.disposeBag = DisposeBag()
    }
    
    func scheduleSections () -> [SectionModel<String, CourseModel>] {
        let schedules = self.courseRepository.getSchedules()
        let sections = self.courseInteractor.extractSectionsFromSchedules(with: schedules)
        return sections
    }
    
    func getScheduleData (handler: @escaping ([SectionModel<String, CourseModel>]) -> ()) {
        handler(self.scheduleSections())
    }
    
    func sync (handler: @escaping ([SectionModel<String, CourseModel>]) -> ()) {
        let user = self.authInteractor.getUserCredentials()
        
        _ = self.authInteractor.constructLoginFormModel(username: user.username, password: user.password)
                .flatMap { [weak self] res -> Observable<[CourseModel]> in
                    guard let self = self else { return Observable.empty() }
                    
                    let newUser = self.authInteractor.getUserCredentials()
                    return self.courseInteractor.getAllSchedules(withTerm: "1610", withCookie: newUser.cookie)
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
                .observeOn(MainScheduler.instance)
                .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
                .subscribe { event in
                    handler(self.scheduleSections())
                }
            }
}

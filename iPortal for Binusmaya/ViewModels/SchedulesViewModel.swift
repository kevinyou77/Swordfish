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
    typealias Dependencies = SchedulesViewModelDependencies

    let authInteractor: AuthInteractor
    let courseInteractor: CourseInteractor

    let courseRepository: ScheduleRepository
    
    let dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, CourseModel>>
    
    var courses: BehaviorRelay<[SectionModel<String, CourseModel>]>
    
    let disposeBag: DisposeBag
    
    init (
        dependencies: Dependencies
    ) {
        self.authInteractor = dependencies.authInteractor
        self.courseInteractor = dependencies.scheduleInteractor
        self.courseRepository = dependencies.scheduleRepository
        
        self.courses = BehaviorRelay(value: [])

        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CourseModel>>(
            configureCell: { (dataSource, tv, indexPath, item) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "SchedulesTableViewCell", for: indexPath) as! SchedulesTableViewCell
                cell.courseTitle.text = item.COURSE_TITLE_LONG
                cell.courseRoom.text = item.ROOM
                cell.courseStart.text = item.MEETING_TIME_START
                cell.courseType.text = item.N_DELIVERY_MODE
                cell.classCampus.text = item.LOCATION
                cell.classSection.text = item.CLASS_SECTION

                return cell
            }
        )
        
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
                    return self.courseInteractor.getAllSchedules(withCookie: newUser.cookie)
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
                .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
                .subscribe { event in
                    handler(self.scheduleSections())
                }
            }
}

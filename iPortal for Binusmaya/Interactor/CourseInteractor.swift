//
//  CourseInteractor.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift
import Realm
import RxDataSources

public class CourseInteractor {
    let scheduleRepository: ScheduleRepository
    let termRepository: TermRepository
    
    init (
        scheduleRepository: ScheduleRepository = ScheduleRepository(),
        termRepository: TermRepository = TermRepository()
    ) {
        self.scheduleRepository = scheduleRepository
        self.termRepository = termRepository
    }
    
    func getAllSchedules (withCookie cookies : String) -> Observable<[CourseModel]> {
        return BimayApi.getAllSchedules(withCookie: cookies)
            .flatMap { [weak self] event -> Observable<[CourseModel]> in
                guard let self = self else { return Observable.empty() }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([CourseModel].self, from: event)
                   
                    return Observable<[CourseModel]>.create { [weak self] observers in
                        guard let self = self else { return Disposables.create() }
                        
                        self.scheduleRepository.saveSchedules(schedule: model)
                        let sc = self.scheduleRepository.filterSchedules(with: model)
                        observers.onNext(sc)
                        observers.onCompleted()
                        
                        return Disposables.create()
                    }
                } catch {
                    print("invalid")
                    return Observable.empty()
                }
            }
    }
    
    func extractSectionsFromSchedules (with schedules: [CourseModel]) -> [SectionModel<String, CourseModel>] {
        var schedulesSections = [SectionModel<String, CourseModel>]()
        let filteredDate = schedules.map { $0.START_DT }
        
        var currVal: String = filteredDate[0]
        schedulesSections.append(
            SectionModel(
                model: currVal as String,
                items: schedules.filter { $0.START_DT == currVal as String }
            )
        )
        
        for val in filteredDate {
            if val != currVal {
                currVal = val
                schedulesSections.append (
                    SectionModel(
                        model: val as String,
                        items: schedules.filter { $0.START_DT == val as String }
                    )
                )
            }
        }
        
        return schedulesSections
    }
}

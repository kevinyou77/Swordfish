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
import RxDataSources

public class ScheduleRepository {
    let disposeBag = DisposeBag()
    
    func saveSchedules (schedule: [CourseModel]) {
        let realm = try! Realm()
        let obj = realm.objects(CourseModel.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: schedule)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func getSchedules () -> [CourseModel] {
        let realm = try! Realm()
        let schedules = Array(realm.objects(CourseModel.self))

        let totalSchedules = schedules.count
        let totalScheduleString = String(totalSchedules)
        let semester = totalScheduleString[totalScheduleString.startIndex]

        let rangeIndex: String
        if totalSchedules >= 100 {
            rangeIndex = String(semester) + "00"
        } else {
            rangeIndex = "0"
        }

        let rangeLowerBound = Int(rangeIndex)!
        let rangeUpperBound = totalSchedules - 1

        var filteredSchedules = [CourseModel]()
        for i in rangeLowerBound...rangeUpperBound {
            filteredSchedules.append(schedules[i])
        }
        
        return filteredSchedules
    }
    
    func filterSchedules(with schedules: [CourseModel]) -> [CourseModel] {
        let totalSchedules = schedules.count
        let totalScheduleString = String(totalSchedules)
        let semester = totalScheduleString[totalScheduleString.startIndex]
        
        let rangeIndex: String
        if totalSchedules >= 100 {
            rangeIndex = String(semester) + "00"
        } else {
            rangeIndex = "0"
        }
        
        let rangeLowerBound = Int(rangeIndex)!
        let rangeUpperBound = totalSchedules - 1
        
        var filteredSchedules = [CourseModel]()
        for i in rangeLowerBound...rangeUpperBound {
            filteredSchedules.append(schedules[i])
        }
        
        return filteredSchedules
    }
}

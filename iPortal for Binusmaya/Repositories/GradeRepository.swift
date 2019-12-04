//
//  ScheduleRepository.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 06/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

public class GradeRepository {
    let disposeBag = DisposeBag()
    
    func saveGrades (grades: [GradeModel]) {
        let realm = try! Realm()
        let obj = realm.objects(CourseGradeModel.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
        Observable.from(optional: grades)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func saveGrade (grade: CourseGradeModel) {
        let realm = try! Realm()
        
        Observable.from(optional: grade)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func saveGrade (grades: [CourseGradeModel]) {
        let realm = try! Realm()
        
        Observable.from(optional: grades)
            .subscribe(realm.rx.add())
            .disposed(by: self.disposeBag)
    }
    
    func deleteGradeModels () {
        let realm = try! Realm()
        let obj = realm.objects(CourseGradeModel.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
    }
    
    func deleteGrades () {
        let realm = try! Realm()
        let obj = realm.objects(Grades.self)
        
        Observable.from(optional: obj)
            .subscribe(realm.rx.delete())
            .disposed(by: self.disposeBag)
    }

    func getGrades (by term: String) -> [CourseGradeModel] {
        let realm = try! Realm()
        return realm.objects(CourseGradeModel.self)
                    .filter("strm contains '\(term)'")
                    .toArray()
    }
}

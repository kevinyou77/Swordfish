//
//  GradeInteractor.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 12/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

public class GradeInteractor {
    let gradeRepository: GradeRepository
    let termRepository: TermRepository
    let userRepository: UserRepository
    
    init (
        gradeRepository: GradeRepository = GradeRepository(),
        termRepository: TermRepository = TermRepository(),
        userRepository: UserRepository = UserRepository()
    ) {
        self.gradeRepository = gradeRepository
        self.termRepository = termRepository
        self.userRepository = userRepository
    }
    
    func getAPIGradeModels () -> Observable<APIGradeModel> {
        let terms = self.termRepository.getTerms()
        let cookie = self.userRepository.getUserCredentials().cookie
        
        let allGrades = terms.map { term in
            return BimayApi.getStudentGrade(by: term.value, with: cookie)
                .flatMap { grade -> Observable<APIGradeModel> in
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(APIGradeModel.self, from: grade)

                        return Observable<APIGradeModel>.create { observers in
                            observers.onNext(model)
                            observers.onCompleted()
                            
                            return Disposables.create()
                        }
                    } catch {
                        print("invalid \(error)")
                        return Observable.empty()
                    }
                }
        }
        
        return Observable.merge(allGrades)
    }
    
    func filterGrades (for grades: [GradeModel], from apiGradeModel: APIGradeModel) -> [CourseGradeModel] {
        if grades.count == 0 { return [] }
        
        var grade = CourseGradeModel()
        var total = [CourseGradeModel]()
        var curr = grades[0].kodemtk
        
        grade.courseCode = grades[0].kodemtk
        grade.courseTitle = grades[0].course
        grade.strm = apiGradeModel.strm
        grade.GPA_CUM = apiGradeModel.credit!.GPA_CUM
        grade.GPA_CUR = apiGradeModel.credit!.GPA_CUR
        grade.course_grade = grades[0].course_grade
        
        for val in grades {
            if curr == val.kodemtk {
                let tempGrade = Grades()
                tempGrade.grade = "\(val.score._rlmInferWrappedType())"
                tempGrade.lam = val.lam
                grade.grades.append(tempGrade)
            } else {
                curr = val.kodemtk
                
                total.append(grade)
                grade = CourseGradeModel()
                
                grade.courseCode = val.kodemtk
                grade.courseTitle = val.course
                grade.strm = apiGradeModel.strm
                grade.course_grade = val.course_grade
                grade.GPA_CUM = apiGradeModel.credit!.GPA_CUM
                grade.GPA_CUR = apiGradeModel.credit!.GPA_CUR
            }
        }
        
        let totalGradesCount = grades.count
        let temp = Grades()
        temp.grade = "\(grades[totalGradesCount - 1].score._rlmInferWrappedType())"
        temp.lam = grades[totalGradesCount - 1].lam
        grade.grades.append(temp)
        total.append(grade)
        
        return total
    }
    
    func getAllGradesFromApi () -> Observable<[GradeModel]> {
        self.gradeRepository.deleteGrades()
        self.gradeRepository.deleteGradeModels()
        
        return self.getAPIGradeModels().flatMap { apiGradeModel -> Observable<[GradeModel]> in
            guard let scores = apiGradeModel.score else { return Observable.empty() }
            if scores.count == 0 { return Observable.empty() }
            
            return Observable<[GradeModel]>.create { [weak self] observers in
                guard let self = self else { return Disposables.create() }
                
                let filteredGrades = self.filterGrades(for: scores, from: apiGradeModel)
                self.gradeRepository.saveGrade(grades: filteredGrades)
                    
                observers.onNext(scores)
                observers.onCompleted()
                
                return Disposables.create()
            }
        }
    }
    
    func getAllGrades () -> [CourseGradeModel] {
        let terms = self.termRepository.getTerms()
        var models = [CourseGradeModel]()
        for val in terms {
            let grades = self.gradeRepository.getGrades(by: val.value)
                
            for grade in grades  {
                models.append(grade)
            }
        }
        
        return models
    }
    
    func getGradeSections () -> [SectionModel<String, CourseGradeModel>] {
        let terms = self.termRepository.getTerms()
        var gradeSections = [SectionModel<String, CourseGradeModel>]()
        var termsCount = terms.count
        
        let grades = self.getAllGrades()
        
        for val in terms {
            let filteredGrades = grades.filter { $0.strm == val.value }
            
            if filteredGrades.count != 0 {
                let sectionModel = SectionModel<String, CourseGradeModel>(
                    model: "Semester \(termsCount)",
                    items: filteredGrades
                )
                gradeSections.append(sectionModel)
            }
            termsCount = termsCount - 1
        }
        
        return gradeSections
    }
}

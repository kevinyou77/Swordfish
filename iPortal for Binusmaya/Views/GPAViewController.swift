//
//  GPAViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 12/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class GPAViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var gpaTableView: UITableView!
    @IBOutlet weak var topNavigation: UINavigationItem!
    
    let gpaViewModel = GPAViewModel()
    let disposeBag = DisposeBag()
    let rc = UIRefreshControl()
    var gradeModels =  BehaviorRelay<[SectionModel<String, CourseGradeModel>]>(value: [])
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CourseGradeModel>>(
        configureCell: { (dataSource, tv, indexPath, item) in
            let cell = tv.dequeueReusableCell(withIdentifier: "GPATableViewCell", for: indexPath) as! GPATableViewCell
            
            cell.courseTitle.text = item.courseTitle
            cell.courseGrade.text = item.course_grade

            var labels = [UILabel]()
            for val in item.grades {
                let label = UILabel()
                label.font = label.font.withSize(13.0)
                
                let lowerBound = val.grade.indexOf(char: "(")! + 1
                let upperBound = val.grade.count - 2
                let extractedGradeString = val.grade[lowerBound...upperBound]
                
                label.text = "\(val.lam) : \(extractedGradeString)"
                
                labels.append(label)
            }
            
            for val in cell.scoreStackView.arrangedSubviews {
                val.removeFromSuperview()
            }
            
            for val in labels  {
                cell.scoreStackView.addArrangedSubview(val)
            }
            
            return cell
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup () {
        self.configureRefreshControl()
        self.setTableView()
        self.setNavigationBarTitleToCurrentGPA()
    }
    
    func setNavigationBarTitleToCurrentGPA () {
        let currentGPA = self.gpaViewModel.culmulativeGPA
        self.topNavigation.title = "GPA - \(currentGPA)"
    }
    
    func configureRefreshControl () {
        self.rc.attributedTitle = NSAttributedString(string: "Fetching GPAs...", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        self.rc.tintColor = UIColor.white
        self.rc.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
        self.gpaTableView.refreshControl = self.rc
    }
    
    @objc func onRefresh (_ sender: Any) {
        self.gpaViewModel.sync { [weak self] in
            guard let self = self else { return }
            
            self.rc.endRefreshing()
        }
    }
    
    func setTableView () {
        self.gpaTableView.delegate = self
        self.gpaTableView.dataSource = nil
        self.gpaTableView.estimatedRowHeight = 100
        self.gpaTableView.rowHeight = UITableView.automaticDimension
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.gpaViewModel.getGPA()
        
        self.dataSource.titleForHeaderInSection = { dataSource, index in
            return self.dataSource.sectionModels[index].model
        }
        
        self.gpaViewModel.gradeModels
            .bind (to: self.gpaTableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = UIColor(red: CGFloat(247.0 / 255.0), green: CGFloat(247.0 / 255.0), blue: CGFloat(247.0 / 255.0), alpha: 1)

            let semesterLabel = UILabel()
            semesterLabel.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width, height: headerView.center.y)
            semesterLabel.font = semesterLabel.font.withSize(15)
            semesterLabel.attributedText = NSAttributedString(
                string: self.dataSource[section].model,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)
                ]
            )

            let averageGPA = UILabel()
            averageGPA.textAlignment = .right
        
            averageGPA.frame = CGRect.init(x: headerView.frame.midX - 20, y: 0, width: headerView.frame.midX, height: headerView.center.y)
        
            let str = "Semester GPA: \(self.dataSource[section].items[section].GPA_CUR)"
            averageGPA.attributedText = NSAttributedString(
                string: str,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)
                ]
            )

            headerView.addSubview(averageGPA)
            headerView.addSubview(semesterLabel)

            return headerView
    }

}

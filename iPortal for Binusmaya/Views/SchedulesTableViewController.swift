//
//  SchedulesTableViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 08/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SchedulesTableViewController: UITableViewController {
    
    @IBOutlet weak var topNavigation: UINavigationItem!
    
    var courses: BehaviorRelay<[SectionModel<String, CourseModel>]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    var schedulesViewModel: SchedulesViewModel = SchedulesViewModel(dependencies: SchedulesViewModelDependencies())
    let rc: UIRefreshControl = UIRefreshControl()
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CourseModel>>(
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup () {
        self.configureRefreshControl()
        self.setTableView()
        self.setNavigationBarTitleToCurrentDate()
    }
    
    func setNavigationBarTitleToCurrentDate () {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL dd"
        let fullDate = dateFormatter.string(from: now)
        
        topNavigation.title = "Today, \(fullDate)"
    }
    
    func configureRefreshControl () {
        self.rc.attributedTitle = NSAttributedString(string: "Fetching schedules...", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        self.rc.tintColor = UIColor.black
        self.rc.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = self.rc
    }
    
    
    func setTableView () {
        self.tableView.delegate = self
        self.tableView.dataSource = nil
        self.tableView.rowHeight = UITableView.automaticDimension
       
        self.courses
            .asDriver()
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        self.schedulesViewModel.getScheduleData { courses in
            self.courses.accept(courses)
        }
    }
    
    @objc func onRefresh (_ sender: Any) {
        self.schedulesViewModel.sync { event in
            self.courses.accept(event)
            self.rc.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dateString = dataSource.sectionModels[section].model[0...10]
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMMM dd"
        
        let date = dateFormatterGet.date(from: dateString)
        
        let fullDate = dateFormatterPrint.string(from: date!)
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: CGFloat(247.0 / 255.0), green: CGFloat(247.0 / 255.0), blue: CGFloat(247.0 / 255.0), alpha: 1)
        
        let dateLabel = UILabel()
        dateLabel.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width, height: headerView.center.y)
        dateLabel.attributedText = NSAttributedString(
            string: fullDate,
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Circular-Bold", size: 15)!
            ]
        )
        
        headerView.addSubview(dateLabel)
        return headerView
    }

}

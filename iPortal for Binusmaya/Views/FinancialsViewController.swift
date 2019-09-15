//
//  FinancialsViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 14/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FinancialsViewController: UIViewController {

    @IBOutlet weak var financialsTableView: UITableView!
    
    let financialsViewModel = FinancialsViewModel(dependencies: FinancialsViewModelDependencies())
    let disposeBag = DisposeBag()
    var financialModels = BehaviorRelay<[FinancialModel]>(value: [])
    let rc = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup () {
        self.configureRefreshControl()
        self.setTableView()
    }
    
    func configureRefreshControl () {
        self.rc.attributedTitle = NSAttributedString(string: "Fetching financials...")
        self.financialsTableView.refreshControl = self.rc
        self.rc.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
    }
    
    @objc func onRefresh (_ sender: Any) {
        self.financialsViewModel.sync { [weak self] model in
            guard let self = self else { return }
            
            self.financialModels.accept(model)
            self.rc.endRefreshing()
        }
    }
    
    func setTableView () {
        self.financialsTableView.delegate = nil
        self.financialsTableView.dataSource = nil
        self.financialsTableView.estimatedRowHeight = 50
        self.financialsTableView.rowHeight = UITableView.automaticDimension
        
        self.financialModels
            .asDriver()
            .drive(self.financialsTableView.rx.items(cellIdentifier: "FinancialsTableViewCell", cellType: FinancialsTableViewCell.self)) { row, model, cell in
                cell.feeAmount.text = "Rp. \(model.item_amt)"
                cell.feeDueDate.text = model.due_dt[0...9].convertDateString()
                
                if model.Status == "Paid" {
                    cell.feeStatus.textColor = UIColor.green
                    cell.feeStatus.text = model.Status
                } else {
                    cell.feeStatus.textColor = UIColor.red
                    cell.feeStatus.text = "Upcoming"
                }
                
                cell.feeName.text = model.descr
            }
            .disposed(by: self.disposeBag)
        
        self.financialsViewModel.getFinancials { event in
            self.financialModels.accept(event)
        }
    }
}

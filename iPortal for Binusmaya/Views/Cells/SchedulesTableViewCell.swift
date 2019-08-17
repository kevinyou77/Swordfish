//
//  SchedulesTableViewCell.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 08/08/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit

class SchedulesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseStart: UILabel!
    @IBOutlet weak var courseRoom: UILabel!
    @IBOutlet weak var courseType: UILabel!
    @IBOutlet weak var classSection: UILabel!
    @IBOutlet weak var classCampus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

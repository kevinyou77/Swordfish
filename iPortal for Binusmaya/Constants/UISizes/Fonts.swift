//
//  Fonts.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 09/09/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit

struct Fonts {
    enum size: Int {
        case defaultSize = 16
    }
    
    var defaultFont: UIFont {
        return UIFont(name: "Circular-Bold", size: 16)!
    }
    
    var smallFont: UIFont {
        return UIFont(name: "Circular-Book", size: 12)!
    }
}

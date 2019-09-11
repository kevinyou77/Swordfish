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
    
    static var primaryFontName: String = "Circular-Bold"
    
    static var headerFont: UIFont {
        return UIFont(name: "Circular-Bold", size: 18)!
    }
    
    static var defaultFont: UIFont {
        return UIFont(name: "Circular-Bold", size: 16)!
    }
    
    static var smallFont: UIFont {
        return UIFont(name: "Circular-Book", size: 12)!
    }
}

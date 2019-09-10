//
//  Screen.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 09/09/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit

struct Screen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    static var getSafeAreaFromWindow: CGRect {
        let window = UIApplication.shared.windows[0]
        let safeFrame = window.safeAreaLayoutGuide.layoutFrame
        
        return safeFrame
    }
    
    static var safeAreaTop: CGFloat {
        return self.getSafeAreaFromWindow.minY
    }
    
    static var safeAreaBottom: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.frame.maxY - self.getSafeAreaFromWindow.maxY
    }
}

//
//  HTStatic.swift
//  Tian
//
//  Created by hublot on 2018/11/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTStatic: NSObject {

    static let size = UIScreen.main.bounds.size

    static let isX = (size.width == 375 && size.height == 812)
        || (size.width == 414 && size.height == 896)
        || (size.width == 360 && size.height == 780)
        || (size.width == 390 && size.height == 844)
    
    static let statusHeight: CGFloat = isX ? 44 : 20
    
    static let navigationHeight: CGFloat = 44 + statusHeight
    
    static let tabbarHeight: CGFloat = isX ? 83 : 49

    static let homeHeight: CGFloat = tabbarHeight - 49
    
}

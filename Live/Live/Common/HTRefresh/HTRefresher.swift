//
//  HTRefresh.swift
//  Shop
//
//  Created by hublot on 2018/6/21.
//  Copyright © 2018年 hublot. All rights reserved.
//

import UIKit
import MJRefresh
import HTSwiftRefresh

public extension Refresher {
    
    public static var circle: Refresher {
        let provider = Refresher()
        provider.headerControl = {
            let header = HTRefreshHeader.init(frame: CGRect.zero)
            return header
        }()
        provider.footerControl = {
            let footer = MJRefreshAutoNormalFooter()
//            footer.stateLabel.isHidden = true
            //            footer.isAutomaticallyHidden = true
            return footer
        }()
        return provider
    }
    
}

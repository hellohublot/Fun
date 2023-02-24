//
//  HTDiscoverPageContentCell.swift
//  Music163
//
//  Created by hublot on 2018/12/12.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTPageContentCell: UICollectionViewCell, ReuseCell {
	
	var lastModel: HTPageModelAble?
		
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard var model = model as? HTPageModelAble else {
			return
		}
        
//        if model.controllerClass == lastModel?.controllerClass, contentView.subviews.first ==  lastModel?.controller?.view {
//            model.controller = lastModel?.controller
//        }
		
		lastModel = model

		
		if model.controller == nil {
			model.controller = model.controllerClass?.init()
		}
        
        if model.controller?.view == contentView.subviews.first {
            return
        }
        
        if let view = model.controller?.view {
            contentView.subviews.first?.removeFromSuperview()
            contentView.addSubview(view)
            model.controller?.view.snp.makeConstraints { (maker) in
                maker.edges.equalTo(UIEdgeInsets.zero)
            }
        }
	}
    
}

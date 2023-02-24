//
//  HTMineStorePolicyBackgroundView.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyRechargeBackgroundView: UICollectionReusableView, ReuseCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
        
}

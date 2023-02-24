//
//  HTSetupFriendBackgroundView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupFriendBackgroundView: UICollectionReusableView, ReuseCell {
	
	lazy var whiteContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(whiteContentView)
		whiteContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
        
}

//
//  HTMineUserPageHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserPageHeaderView: UITableViewHeaderFooterView, ReuseCell {

	static let pageHeaderHeight: CGFloat = 44

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		backgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		backgroundView?.backgroundColor = UIColor.white
		
		backgroundView?.layer.shadowColor = UIColor.black.cgColor
		backgroundView?.layer.shadowOffset = CGSize.init(width: 0, height: 1)
		backgroundView?.layer.shadowOpacity = 0.05
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {

	}

}

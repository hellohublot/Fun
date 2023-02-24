//
//  HTMineStoreSeatRecommendHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreSeatRecommendHeaderView: UICollectionReusableView, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 13, bottom: 0, right: 13))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreSeatSectionModel else {
			return
		}
		titleLabel.text = model.title
	}
        
}

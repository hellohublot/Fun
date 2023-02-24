//
//  HTVideoTopicHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoTopicHeaderView: UICollectionReusableView, ReuseCell {
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "2ffed0fcd9732e0d92a6fa490878916a"), for: .normal)
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.contentHorizontalAlignment = .left
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		return button
	}()
	
	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "30ab9884253ac9da7bff8a88454d645c"), for: .normal)
		button.contentHorizontalAlignment = .right
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		addSubview(detailButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.centerY.equalTo(self)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleButton.snp.right).offset(10)
			maker.right.equalTo(-10)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTVideoTopicSectionModel else {
			return
		}
		titleButton.setTitle(model.actitle, for: .normal)
		detailButton.setTitle("\(model.total)", for: .normal)
	}
        
}

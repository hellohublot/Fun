//
//  HTLiveSearchPlaceholderSectionHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveSearchPlaceholderSectionHeaderView: UICollectionReusableView, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "52458c635706c5986052834a6ca6ac70"), for: .normal)
		button.setTitle("清空", for: .normal)
		button.contentHorizontalAlignment = .right
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		addSubview(detailButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(self)
			maker.right.lessThanOrEqualTo(detailButton.snp.left)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveSearchPlaceholderSectionModel else {
			return
		}
		titleLabel.text = model.title
		detailButton.isHidden = !(model.showClearButton ?? false)
	}
        
}

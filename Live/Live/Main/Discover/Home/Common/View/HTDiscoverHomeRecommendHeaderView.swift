//
//  HTDiscoverHomeRecommendHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeRecommendHeaderView: UICollectionReusableView, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 10)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.isUserInteractionEnabled = false
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(12)
			maker.centerY.equalTo(self)
			maker.right.equalTo(-12)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeSectionModel else {
			return
		}
		titleButton.setImage(UIImage.init(named: model.image ?? ""), for: .normal)
		titleButton.setTitle(model.title, for: .normal)
	}
        
}

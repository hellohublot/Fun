//
//  HTLiveHotRecommendFooterView.swift
//  Live
//
//  Created by hublot on 2018/12/30.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveHotRecommendFooterView: UICollectionReusableView, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 1, green: 0.39, blue: 0.52, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "cd3baa8a1fbd1e37915480b80204d50b"), for: .normal)
		button.setTitle("查看全部推荐", for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: -8)
		button.layer.cornerRadius = 3
		button.layer.borderColor = UIColor.init(red: 1, green: 0.39, blue: 0.52, alpha: 1).cgColor
		button.layer.borderWidth = 1 / UIScreen.main.scale
		button.layer.masksToBounds = true
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.center.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {

	}

}

//
//  HTLiveSearchPlaceholderHistoryCell.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveSearchPlaceholderHistoryCell: UICollectionViewCell, ReuseCell {
	
	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let model = model as? HTLiveSearchPlaceholderHistoryModel else {
			return CGSize.zero
		}
		let width = (max(25, model.title?.size(titleLabelFont, superSize).width ?? 0)) + 15 
		return CGSize.init(width: width, height: superSize.height)
	}
	
	static let titleLabelFont = UIFont.systemFont(ofSize: 13)
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = type(of: self).titleLabelFont
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
		label.layer.masksToBounds = true
		label.textAlignment = .center
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel.layer.cornerRadius = titleLabel.bounds.size.height / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveSearchPlaceholderHistoryModel else {
			return
		}
		titleLabel.text = model.title
	}
	
}

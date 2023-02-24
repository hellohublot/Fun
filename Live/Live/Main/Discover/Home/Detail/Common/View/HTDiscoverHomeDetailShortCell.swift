//
//  HTDiscoverHomeDetailShortCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailShortCell: UICollectionViewCell, ReuseCell {

	static let titleLabelFont = UIFont.systemFont(ofSize: 12)

	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let model = model as? HTDiscoverHomeDetailModel else {
			return CGSize.zero
		}
		let width = superSize.width - 30
		var height = model.familyInfo?.fdesc.height(titleLabelFont, width) ?? 0
		height += 100
		return CGSize.init(width: superSize.width, height: height)
	}

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = type(of: self).titleLabelFont
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.numberOfLines = 0
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.right.equalTo(-15)
			maker.top.equalTo(0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeDetailModel else {
			return
		}
		titleLabel.text = model.familyInfo?.fdesc
	}
    
}

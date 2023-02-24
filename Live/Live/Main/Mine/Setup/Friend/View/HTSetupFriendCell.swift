//
//  HTSetupFriendCell.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupFriendCell: UICollectionViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.black
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var selectedButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "d392934356e7ddc93d54ed2cdf2d7b64"), for: .normal)
		button.setImage(UIImage.init(named: "fa435f798f560b3ba30b1e09b3547c5e"), for: .selected)
		button.contentHorizontalAlignment = .right
		button.isUserInteractionEnabled = false
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		addSubview(selectedButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(27)
			maker.top.bottom.equalTo(0)
		}
		selectedButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel.snp.right).offset(15)
			maker.right.equalTo(-27)
			maker.centerY.equalTo(self)
		}
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTSetupFriendModel else {
			return
		}
		titleLabel.text = model.title
		selectedButton.isSelected = model.selected ?? false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

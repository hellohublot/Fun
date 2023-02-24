//
//  HTSetupAnimationCell.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupAnimationCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.black
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var switchControl: UISwitch = {
		let switchControl = UISwitch.init(frame: CGRect.zero)
		switchControl.onTintColor = UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
		return switchControl
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		addSubview(switchControl)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(27)
			maker.top.bottom.equalTo(0)
			maker.right.equalTo(switchControl.snp.left).offset(-10)
		}
		switchControl.snp.makeConstraints { (maker) in
			maker.right.equalTo(-27)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTSetupAnimationModel else {
			return
		}
		titleLabel.text = model.title
		switchControl.isOn = model.selected ?? false
	}

    
}

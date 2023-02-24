//
//  HTVideoRecordSpeedCell.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoRecordSpeedCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitleColor(UIColor.init(red: 0.21, green: 0.14, blue: 0.03, alpha: 1), for: .selected)
		button.isUserInteractionEnabled = false
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(titleButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTVideoRecordSpeedModel else {
			return
		}
		titleButton.setTitle(model.title, for: .normal)
	}
	
}

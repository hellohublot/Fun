//
//  HTMineStoreNumberHeaderCell.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreNumberHeaderCell: UICollectionViewCell, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.setTitleColor(UIColor.white, for: .selected)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)), for: .normal)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)), for: .selected)
		button.layer.masksToBounds = true
		button.isUserInteractionEnabled = false
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.centerY.equalTo(self)
			maker.height.equalTo(30)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		titleButton.layer.cornerRadius = titleButton.bounds.size.height / 2.0
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreNumberPageModel else {
			return
		}
		titleButton.setTitle(model.title, for: .normal)
		titleButton.isSelected = model.selected
	}

    
}

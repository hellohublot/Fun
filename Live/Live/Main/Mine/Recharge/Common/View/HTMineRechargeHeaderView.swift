//
//  HTMineRechargeHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineRechargeHeaderView: UICollectionReusableView, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 13)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.text = "充值账号: hublot"
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.setTitle("九币余额: 0", for: .normal)
		button.setImage(UIImage.init(named: "9c9d34591dc0c7321cdfc028adf3fc32"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		addSubview(detailButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(self)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel.snp.right).offset(10)
			maker.right.equalTo(-15)
			maker.centerY.equalTo(self)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
        
}

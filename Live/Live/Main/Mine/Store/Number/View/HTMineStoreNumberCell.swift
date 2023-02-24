//
//  HTMineStoreNumberCell.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreNumberCell: UICollectionViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 23)
		label.textColor = UIColor.white
		label.textAlignment = .center
		return label
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 0]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
		return gradientLayer
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textAlignment = .center
		label.text = "购买"
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = titleLabel.bounds
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.layer.insertSublayer(gradientLayer, at: 0)
		layer.cornerRadius = 5
		contentView.layer.cornerRadius = layer.cornerRadius
		contentView.layer.masksToBounds = true

		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		layer.shadowOpacity = 0.11
		layer.shadowRadius = 12
		layer.shadowOffset = CGSize.init(width: 0, height: 3)
		layer.borderWidth = 1 / UIScreen.main.scale
		layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor

		addSubview(titleLabel)
		addSubview(detailLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.top.right.equalTo(0)
			maker.bottom.equalTo(detailLabel.snp.top)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.bottom.left.right.equalTo(0)
			maker.height.equalTo(self).multipliedBy(0.4)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreNumberModel else {
			return
		}
		gradientLayer.colors = model.colorList
		titleLabel.text = model.accountid
		detailLabel.textColor = model.textColor
	}
    
}

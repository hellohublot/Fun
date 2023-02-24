//
//  HTMineBadgeCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineBadgeCell: UICollectionViewCell, ReuseCell {

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .center
		label.numberOfLines = 2
		return label
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 0.627451, green: 0.627451, blue: 0.627451, alpha: 1).cgColor,
			UIColor.init(red: 0.745098, green: 0.745098, blue: 0.745098, alpha: 1).cgColor,
		]
		return gradientLayer
	}()

	lazy var statusButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("未获得", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		gradientLayer.frame = statusButton.bounds
		statusButton.layer.cornerRadius = statusButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor.white
		layer.cornerRadius = 5

		layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		layer.shadowOpacity = 0.11
		layer.shadowRadius = 12
		layer.shadowOffset = CGSize.init(width: 0, height: 3)
		layer.borderWidth = 1 / UIScreen.main.scale
		layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor


		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(statusButton)
		headImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(20)
			maker.centerX.equalTo(self)
			maker.width.height.equalTo(48)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(14)
			maker.left.equalTo(30)
			maker.right.equalTo(-30)
		}
		statusButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-20)
			maker.centerX.equalTo(self)
			maker.width.equalTo(97)
			maker.height.equalTo(23)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineBadgeModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.url), placeholder: Request.placeImage)
		titleLabel.text = model.desc
	}

}

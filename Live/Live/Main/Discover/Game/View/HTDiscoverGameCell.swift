//
//  HTDiscoverGameCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverGameCell: UICollectionViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 17)
		label.textColor = UIColor.white
		return label
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 1, green: 0.447059, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.713725, blue: 0.541176, alpha: 1).cgColor,
		]
		return gradientLayer
	}()

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("进入", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		button.isUserInteractionEnabled = false
		return button
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = titleButton.bounds
		titleButton.layer.cornerRadius = titleButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(backgroundImageView)
		contentView.addSubview(titleLabel)
		addSubview(titleButton)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-13)
			maker.top.equalTo(17)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(15)
			maker.right.equalTo(titleLabel).offset(-3)
			maker.width.equalTo(50.5)
			maker.height.equalTo(18.5)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverGameModel else {
			return
		}
		let image = UIImage.init(named: model.image ?? "")
		backgroundImageView.image = image
		titleLabel.text = model.title
	}
    
}

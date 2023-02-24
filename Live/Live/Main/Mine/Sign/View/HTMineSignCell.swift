//
//  HTMineSignCell.swift
//  Live
//
//  Created by hublot on 2019/2/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineSignCell: UICollectionViewCell, ReuseCell {

	lazy var sunImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "946daeafae6d517c1d08f0203c703b9c")
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 1, green: 0.47, blue: 0.47, alpha: 1)
		label.textAlignment = .center
		return label
	}()

	lazy var titleImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 255 / 255.0, green: 190 / 255.0, blue: 156 / 255.0, alpha: 1).cgColor,
			UIColor.init(red: 255 / 255.0, green: 160 / 255.0, blue: 160 / 255.0, alpha: 1).cgColor,
		]
		return gradientLayer
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.white
		label.textAlignment = .center
		label.layer.insertSublayer(gradientLayer, at: 0)
		return label
	}()

	lazy var textLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 1, green: 0.47, blue: 0.47, alpha: 1)
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = detailLabel.bounds
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.init(red: 255 / 255.0, green: 238 / 255.0, blue: 239 / 255.0, alpha: 1)
		layer.cornerRadius = 3
		layer.masksToBounds = true
		layer.borderWidth = 1
		addSubview(sunImageView)
		addSubview(titleImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(textLabel)
		sunImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		titleImageView.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(sunImageView)
			maker.centerY.equalTo(sunImageView).offset(-5)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(3)
			maker.left.right.equalTo(0)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(20)
		}
		textLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-3)
			maker.bottom.equalTo(detailLabel.snp.top).offset(-3)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineSignModel else {
			return
		}
		layer.borderColor = model.selected == true ? UIColor.init(red: 255 / 255.0, green: 160 / 255.0, blue: 160 / 255.0, alpha: 1).cgColor : UIColor.clear.cgColor
		sunImageView.isHidden = model.selected == false
		titleImageView.image = UIImage.init(named: model.image ?? "")
		titleLabel.text = model.title
		detailLabel.text = model.detail
		textLabel.text = model.text
	}
    
}

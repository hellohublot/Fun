//
//  HTDiscoverNewCell.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = darkGradientLayer.cornerRadius
		imageView.layer.addSublayer(darkGradientLayer)
		return imageView
	}()
	
	lazy var darkGradientLayer: CALayer = {
		let layer = CAGradientLayer.init()
		layer.colors = [
			UIColor.init(white: 0, alpha: 0).cgColor,
			UIColor.init(white: 0, alpha: 0).cgColor,
			UIColor.init(white: 0, alpha: 0.3).cgColor
		]
		layer.locations = [0, 0.5, 1]
		layer.startPoint = CGPoint.zero
		layer.endPoint = CGPoint.init(x: 0, y: 1)
		layer.cornerRadius = 5
		layer.masksToBounds = true
		return layer
	}()
	
	lazy var visitCountButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage.init(named: "e3d1cb5b90d4e5c456f7cd84b00111fd"), for: .normal)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		darkGradientLayer.frame = backgroundImageView.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(visitCountButton)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
			maker.bottom.equalTo(0)
		}
		visitCountButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(backgroundImageView).offset(5)
			maker.bottom.equalTo(backgroundImageView).offset(-5)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveContentModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.phonehallposter), placeholder: Request.placeImage)
		visitCountButton.setTitle("\(model.usercount)", for: .normal)
	}

    
}

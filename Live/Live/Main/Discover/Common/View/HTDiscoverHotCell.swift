//
//  HTDiscoverHotCell.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHotCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.layer.addSublayer(darkGradientLayer)
		imageView.setContentHuggingPriority(UILayoutPriority.init(100), for: .vertical)
		imageView.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .vertical)
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
		return layer
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		darkGradientLayer.frame = backgroundImageView.bounds
		CATransaction.commit()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.layer.masksToBounds = true
		contentView.layer.cornerRadius = 5
		
		layer.cornerRadius = contentView.layer.cornerRadius
		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.init(white: 0.66, alpha: 1).cgColor
		layer.shadowOpacity = 0.25
		layer.shadowOffset = CGSize.init(width: -1.5, height: 4)
		
		contentView.addSubview(backgroundImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.right.equalTo(-5)
			maker.bottom.equalTo(backgroundImageView).offset(-6)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(backgroundImageView.snp.bottom).offset(6)
			maker.bottom.equalTo(-6)
			maker.left.right.equalTo(titleLabel)
			maker.height.equalTo(20)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.info?.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.info?.nickname
		detailLabel.attributedText = model.indexContentAttributedString
	}
    
}

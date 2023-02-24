//
//  HTVideoTopicCell.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoTopicCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 10)
		label.textColor = UIColor.white
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.layer.masksToBounds = true
		contentView.layer.cornerRadius = 5
		
		layer.cornerRadius = contentView.layer.cornerRadius
		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		layer.shadowOpacity = 0.11
		layer.shadowRadius = 12
		layer.shadowOffset = CGSize.init(width: 0, height: 3)
		layer.borderWidth = 1 / UIScreen.main.scale
		layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor
		contentView.addSubview(backgroundImageView)
		contentView.addSubview(titleLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-10)
			maker.bottom.equalTo(-10)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTVideoContentModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.imageurl), placeholder: Request.placeImage)
		var visitCountString = "\(model.viewnum)"
		if model.viewnum >= 10000 {
			visitCountString = "\(String.init(format: "%.1f", Double(model.viewnum) / 10000.0))万"
		}
		titleLabel.text = "\(visitCountString)围观"
	}
    
}

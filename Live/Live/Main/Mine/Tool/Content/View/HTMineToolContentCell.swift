//
//  HTMineToolContentCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineToolContentCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.setContentHuggingPriority(UILayoutPriority.init(100), for: .vertical)
		imageView.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .vertical)
		return imageView
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.black
		label.textAlignment = .center
		return label
	}()
	
	lazy var countLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.init(name: "Arial-BoldItalicMT", size: 15)
		label.textColor = UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
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
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(headImageView)
		contentView.addSubview(detailLabel)
		contentView.addSubview(countLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(15)
			maker.left.equalTo(10)
			maker.right.equalTo(-10)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(30)
			maker.left.equalTo(30)
			maker.right.equalTo(-30)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(30)
			maker.left.equalTo(10)
			maker.right.equalTo(-10)
			maker.bottom.equalTo(-15)
		}
		countLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.bottom.equalTo(detailLabel.snp.top).offset(-15)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineToolModel else {
			return
		}
		titleLabel.text = model.name
		detailLabel.text = "有效期: \(model.deadLine)天"
		headImageView.kf.setImage(with: Request.url(model.imgurl), placeholder: Request.placeImage)
		countLabel.text = "x\(model.num)"
	}
	
}

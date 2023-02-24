//
//  HTDiscoverHomeDetailInfoCell.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailInfoCell: UICollectionViewCell, ReuseCell {

	static let detailLabelFont = UIFont.systemFont(ofSize: 12)

	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let model = model as? HTDiscoverHomeDetailModel else {
			return CGSize.zero
		}
		let width = superSize.width - 90
		var height = model.familyInfo?.fnotic.height(detailLabelFont, width) ?? 0
		height += 280
		return CGSize.init(width: superSize.width, height: height)
	}

	lazy var whiteContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.masksToBounds = true
		view.layer.cornerRadius = 10
		return view
	}()

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderColor = UIColor.white.cgColor
		imageView.layer.borderWidth = 1
		return imageView
	}()

	lazy var nameLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 15)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .center
		return label
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .left
		label.text = "公告: "
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = type(of: self).detailLabelFont
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.textAlignment = .left
		label.numberOfLines = 0
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(whiteContentView)
		addSubview(headImageView)
		addSubview(nameLabel)
		addSubview(titleLabel)
		addSubview(detailLabel)
		whiteContentView.snp.makeConstraints { (maker) in
			maker.left.equalTo(12)
			maker.right.equalTo(-12)
			maker.bottom.equalTo(0)
			maker.top.equalTo(headImageView.snp.centerY)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(whiteContentView)
			maker.top.equalTo(120)
			maker.width.height.equalTo(100)
		}
		nameLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(10)
			maker.left.equalTo(whiteContentView).offset(15)
			maker.right.equalTo(whiteContentView).offset(-15)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(nameLabel.snp.bottom).offset(15)
			maker.right.equalTo(whiteContentView).offset(-15)
			maker.left.equalTo(titleLabel.snp.right)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(whiteContentView).offset(10)
			maker.top.equalTo(detailLabel)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeDetailModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.familyInfo?.fbackground), placeholder: Request.placeImage)
		nameLabel.text = model.familyInfo?.fname
		detailLabel.text = model.familyInfo?.fnotic
	}
    
}

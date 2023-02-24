//
//  HTMineBadgeHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineBadgeHeaderView: UICollectionReusableView, ReuseCell {

	lazy var contentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.cornerRadius = 5

		view.layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		view.layer.shadowOpacity = 0.11
		view.layer.shadowRadius = 12
		view.layer.shadowOffset = CGSize.init(width: 0, height: 3)
		view.layer.borderWidth = 1 / UIScreen.main.scale
		view.layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor
		return view
	}()

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()

	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "073f60e723d0b0685d430faff9bb3208")
		return imageView
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(contentView)
		addSubview(headImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		contentView.addSubview(flagImageView)
		contentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10))
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(contentView).offset(15)
			maker.centerY.equalTo(contentView)
			maker.width.height.equalTo(45)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(20)
			maker.top.equalTo(headImageView).offset(2)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView).offset(-2)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-20)
			maker.top.bottom.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		let userModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
		headImageView.kf.setImage(with: Request.url(userModel?.headimage), placeholder: Request.placeImage)
		titleLabel.text = userModel?.nickname
		detailLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let normalDictionary: [NSAttributedStringKey: Any] = [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]
			let selectedDictionary: [NSAttributedStringKey: Any] = [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
			]
			attributedString.append(NSAttributedString.init(string: "已获得", attributes: normalDictionary))
			attributedString.append(NSAttributedString.init(string: "0", attributes: selectedDictionary))
			attributedString.append(NSAttributedString.init(string: "枚徽章", attributes: normalDictionary))
			return attributedString
		}()
	}
        
}

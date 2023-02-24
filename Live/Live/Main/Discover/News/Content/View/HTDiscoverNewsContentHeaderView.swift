//
//  HTDiscoverNewsContentHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentHeaderView: UITableViewHeaderFooterView, ReuseCell {
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(white: 0.5, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.backgroundColor = UIColor.init(red: 1, green: 0.3, blue: 0.48, alpha: 1)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13)
		button.setTitle("关注", for: .normal)
		button.layer.masksToBounds = true
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		followButton.layer.cornerRadius = followButton.bounds.size.height / 2.0
	}
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(followButton)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(37)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView)
			maker.left.equalTo(headImageView.snp.right).offset(10)
			maker.right.equalTo(followButton.snp.left).offset(-20)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(headImageView)
			maker.left.equalTo(titleLabel)
			maker.right.equalTo(followButton.snp.left).offset(-20)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.right.equalTo(-10)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let sectionModel = model as? HTDiscoverNewsContentSectionModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(sectionModel.model.info?.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 15)
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: sectionModel.model.info?.nickname ?? "", attributes: [
				.font: font,
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]))
			var image = UIImage.init(named: "level_\(sectionModel.model.info?.creditLevel ?? 0)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0))
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			return attributedString
		}()
		let dateFormatter = DateFormatter.init()
		dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
		let date = Date.init(timeIntervalSince1970: Double(sectionModel.model.addtime) ?? 0)
		let dateString = dateFormatter.string(from: date)
		detailLabel.text = dateString
		followButton.isHidden = sectionModel.model.isfollow == 1
	}
	
}

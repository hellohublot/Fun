//
//  HTMineUserFansCell.swift
//  Live
//
//  Created by hublot on 2019/1/22.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserFansCell: UITableViewCell, ReuseCell {
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.width.height.equalTo(50)
			maker.centerY.equalTo(self)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.top.equalTo(headImageView).offset(5)
			maker.right.equalTo(-15)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView).offset(-5)
			maker.right.equalTo(-15)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineUserFansModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 14)
			let attributedString = NSMutableAttributedString.init()
			var image = UIImage.init(named: "wealth_\(model.wealthlevel)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5))
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: font,
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]))
			return attributedString
		}()
		detailLabel.text = "粉丝数: \(model.fansnum)"

	}

}

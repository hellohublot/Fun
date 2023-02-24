//
//  HTDiscoverHomeDetailMemberListCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailMemberListCell: UITableViewCell, ReuseCell {

	static let wealthValueList = [
		2000,
		12000,
		42000,
		142000,
		342000,
		742000,
		1542000,
		3142000,
		5742000,
		9742000,
		16242000,
		26242000,
		41242000,
		61242000,
		86242000,
		121242000,
		171242000,
		251242000,
		271242000,
		441242000,
		671242000,
		971242000,
		1351242000,
		1821242000,
		2391242000,
		3071242000,
		4051242000,
		5331242000,
		7891242000,
		10891242000,
		15891242000,
		23891242000
	]

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

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(headImageView)
		addSubview(titleLabel)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(50)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.right.equalTo(-15)
			maker.centerY.equalTo(headImageView)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeDetailMemberModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 14)
			let attributedString = NSMutableAttributedString.init()

			let wealthCount = (Int(model.wealth) ?? 0)
			var wealthLevel = 1
			for (index, wealthValue) in type(of: self).wealthValueList.enumerated() {
				if wealthCount < wealthValue {
					wealthLevel = index
					break
				}
			}
			var image = UIImage.init(named: "wealth_\(wealthLevel)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 15))
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
	}

}

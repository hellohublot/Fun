//
//  HTDiscoverNewsDetailReplyCell.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsDetailReplyCell: UITableViewCell, ReuseCell {

	static let headImageWidth: CGFloat = 30

	static let headImageLeft: CGFloat = 15

	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let model = model as? HTDiscoverNewsContentReplyModel else {
			return CGSize.zero
		}
		let width = superSize.width - headImageLeft - headImageWidth - 10 - 10
		var height = model.replyDetailAttributedString?.size(CGSize.init(width: width, height: 0)).height ?? 0
		height += 10
		height += 10
		return CGSize.init(width: superSize.width, height: height)
	}

	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
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
		label.numberOfLines = 0
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(separatorView)
		addSubview(headImageView)
		addSubview(titleLabel)
		separatorView.snp.makeConstraints { (maker) in
			maker.bottom.right.equalTo(0)
			maker.left.equalTo(titleLabel)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(type(of: self).headImageLeft)
			maker.top.equalTo(10)
			maker.width.height.equalTo(type(of: self).headImageWidth)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(10)
			maker.right.equalTo(-10)
			maker.top.equalTo(headImageView)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentReplyModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = model.replyDetailAttributedString
	}

}

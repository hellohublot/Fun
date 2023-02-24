//
//  HTLiveDetailFansView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveDetailFansView: UIView, ReuseCell {

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderColor = UIColor.init(red: 0.972549, green: 0.756863, blue: 0.282353, alpha: 1).cgColor
		imageView.layer.borderWidth = 1
		return imageView
	}()

	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(headImageView)
		addSubview(flagImageView)
		headImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(-4)
			maker.top.equalTo(-4)
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
		guard let model = model as? String else {
			return
		}
		let flagImageList = ["a6e5fb7e383f19eea4feec4d8090708e", "9b3b373764ee6ff6d7e56ef0f6ddb422", "84d082bae7cc65b0074a27b7822f4a59"]
		let flagImageName = indexPath.row >= flagImageList.count ? flagImageList.first : flagImageList[indexPath.row]
		flagImageView.image = UIImage.init(named: flagImageName ?? "")
		headImageView.kf.setImage(with: Request.url(model), placeholder: Request.placeImage)
	}

}

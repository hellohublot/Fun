//
//  HTDiscoverHomeDetailBackgroundView.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import Kingfisher

class HTDiscoverHomeDetailBackgroundView: UIView {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.centerX.equalTo(self).offset(0)
			maker.width.equalTo(self).offset(0)
			maker.height.equalTo(0)
		}
	}

	func reloadTableViewContentOffset(_ offset: CGFloat) {
		var height: CGFloat = 230
		var top: CGFloat = 0
		if offset >= 0 {
			height += offset
		} else {
			top += offset
		}
		backgroundImageView.snp.updateConstraints { (maker) in
			maker.top.equalTo(top)
			maker.height.equalTo(height)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: HTDiscoverHomeDetailModel?) {
		let imageModifier = AnyImageModifier.init { (fromImage) -> Image in
			return fromImage.kf.blurred(withRadius: 100)
		}
		backgroundImageView.kf.setImage(with: Request.url(model?.familyInfo?.fbackground), placeholder: Request.placeImage, options: [.imageModifier(imageModifier)])
	}



}

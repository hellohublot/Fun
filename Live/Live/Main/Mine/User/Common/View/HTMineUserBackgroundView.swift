//
//  HTMineUserBackgroundView.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import Kingfisher

class HTMineUserBackgroundView: UIView {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var darkView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
		return view
	}()
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(darkView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.centerX.equalTo(self).offset(0)
			maker.width.equalTo(self).offset(0)
			maker.height.equalTo(0)
		}
		darkView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(backgroundImageView)
		}
	}

	func reloadTableViewContentOffset(_ offset: CGFloat) {
		var height: CGFloat = 270
		var top: CGFloat = 0
		if offset >= 0 {
			height += offset
		} else {
			top += offset
			top = max(-(height - HTStatic.navigationHeight), top)
		}
		backgroundImageView.snp.updateConstraints { (maker) in
			maker.top.equalTo(top)
			maker.height.equalTo(height)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: HTMineUserInfoModel?) {
		let imageModifier = AnyImageModifier.init { (fromImage) -> Image in
			return fromImage.kf.blurred(withRadius: 15)
		}
		backgroundImageView.kf.setImage(with: Request.url(model?.phonehallposter), placeholder: Request.placeImage, options: [.imageModifier(imageModifier)])
	}
	

}

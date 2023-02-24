//
//  HTMineBackgroundView.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTMineBackgroundView: UIView {

	lazy var headerImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "39b8701035aa11f0cea5e993f00133df")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 141, right: 0), resizingMode: .stretch)
		imageView.image = image
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(headerImageView)
		headerImageView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.equalTo(0)
			maker.height.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func reloadCollectionContentOffset(_ offset: CGFloat) {
		let normalHeight: CGFloat = 190
		headerImageView.snp.updateConstraints { (maker) in
			if offset > 0 {
				maker.top.equalTo(0)
				maker.height.equalTo(normalHeight + offset)
			} else {
				maker.height.equalTo(normalHeight)
				maker.top.equalTo(offset)
			}
		}
	}
	
}

//
//  HTMineUserPhotoCell.swift
//  Live
//
//  Created by hublot on 2019/1/17.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserPhotoCell: UICollectionViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 5
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineUserPhotoModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.photothumburl), placeholder: Request.placeImage)
	}

}

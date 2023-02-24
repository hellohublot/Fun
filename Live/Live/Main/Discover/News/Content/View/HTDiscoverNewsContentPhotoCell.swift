//
//  HTDiscoverNewsContentImageCell.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentPhotoCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgrondImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 3
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgrondImageView)
		backgrondImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentPhotoModel else {
			return
		}
		backgrondImageView.kf.setImage(with: Request.url(model.photothumburl), placeholder: Request.placeImage)
	}
    
}

//
//  HTMineUserHeaderBadgeCell.swift
//  Live
//
//  Created by hublot on 2019/1/17.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserHeaderBadgeCell: UICollectionViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		backgroundImageView.layer.cornerRadius = backgroundImageView.bounds.size.width / 2.0
	}

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
		guard let model = model as? String else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model), placeholder: Request.placeImage)
	}
    
}

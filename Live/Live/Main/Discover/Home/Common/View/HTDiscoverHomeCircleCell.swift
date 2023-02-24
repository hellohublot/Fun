//
//  HTDiscoverHomeCircleCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeCircleCell: UICollectionViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.white
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(titleLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.center.equalTo(self)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(self)
			maker.bottom.equalTo(-13)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeCircleModel else {
			return
		}
		backgroundImageView.image = UIImage.init(named: model.image ?? "")
		titleLabel.text = model.title
	}
    
}

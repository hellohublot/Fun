//
//  HTDiscoverHomeDetailLeaderCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailLeaderCell: UICollectionViewCell, ReuseCell {

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(headImageView)
		addSubview(titleLabel)
		headImageView.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(72)
			maker.left.equalTo(20)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(headImageView)
			maker.left.equalTo(headImageView.snp.right).offset(10)
			maker.right.equalTo(-10)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeDetailLeaderModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.nickname
	}

    
}

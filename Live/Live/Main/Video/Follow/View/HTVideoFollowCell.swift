//
//  HTVideoFollowCell.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import Kingfisher

class HTVideoFollowCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var darkView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "1acbdfe77efa2e5e84e61b897b0265ff")
		return imageView
	}()
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 11)
		label.textColor = UIColor.white
		label.textAlignment = .right
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleButton.imageView?.layer.cornerRadius = (titleButton.imageView?.bounds.size.height ?? 0) / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(darkView)
		addSubview(titleButton)
		addSubview(detailLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		darkView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(70)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.bottom.equalTo(-5)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-5)
			maker.centerY.equalTo(titleButton)
			maker.left.equalTo(titleButton.snp.right).offset(5)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTVideoContentModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.imageurl), placeholder: Request.placeImage)
		titleButton.setTitle(model.nickname, for: .normal)
		let imageModifier = AnyImageModifier.init(modify: { (fromImage) -> UIImage in
			let scale = 28.0 / fromImage.size.width
			return fromImage.imageWith(zoom: scale)
		})
		titleButton.kf.setImage(with: Request.url(model.headimage), for: .normal, placeholder: Request.placeImage, options: [.imageModifier(imageModifier)])
		var visitCountString = "\(model.viewnum)"
		if model.viewnum >= 10000 {
			visitCountString = "\(String.init(format: "%.1f", Double(model.viewnum) / 10000.0))万"
		}
		detailLabel.text = "\(visitCountString)人围观"
	}
    
}

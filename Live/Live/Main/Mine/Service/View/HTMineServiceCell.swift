//
//  HTMineServiceCell.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineServiceCell: UITableViewCell, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.black, for: .normal)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		return button
	}()
	
	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1), for: .normal)
		button.contentHorizontalAlignment = .right
		return button
	}()
	
	lazy var accessoryImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "286e02771b1642fbcf71e7f7d4c68653")
		return imageView
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(titleButton)
		addSubview(detailButton)
		addSubview(accessoryImageView)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(self)
			maker.right.equalTo(detailButton.snp.left).offset(-10)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(accessoryImageView.snp.left).offset(-10)
			maker.centerY.equalTo(self)
		}
		accessoryImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineServiceModel else {
			return
		}
		titleButton.setTitle(model.title, for: .normal)
		titleButton.setImage(UIImage.init(named: model.image), for: .normal)
		detailButton.setTitle(model.comment, for: .normal)
	}

}

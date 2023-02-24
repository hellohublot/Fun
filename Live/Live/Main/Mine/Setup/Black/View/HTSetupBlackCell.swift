//
//  HTSetupBlackCell.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupBlackCell: UITableViewCell, ReuseCell {
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var wealthImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var removeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.backgroundColor = UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
		button.layer.masksToBounds = true
		button.setTitle("移出", for: .normal)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		removeButton.layer.cornerRadius = removeButton.bounds.size.height / 2.0
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(wealthImageView)
		addSubview(removeButton)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(50)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(10)
			maker.top.equalTo(headImageView)
			maker.right.equalTo(removeButton.snp.left).offset(-10)
		}
		wealthImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView).offset(-5)
		}
		removeButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.right.equalTo(-15)
			maker.width.equalTo(67)
			maker.height.equalTo(25)
		}
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTSetupBlackModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.nickname
		wealthImageView.image = UIImage.init(named: "wealth_\(model.wealthlevel)_33x14_")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

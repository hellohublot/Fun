//
//  HTSetupActionCell.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupActionCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(white: 0.67, alpha: 1)
		label.textAlignment = .right
		return label
	}()
		
	lazy var accessoryImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "e977d40dba2bb81bff75e71987866a0e")
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		contentView.addSubview(accessoryImageView)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(26)
			maker.top.bottom.equalTo(contentView)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel.snp.right).offset(-15)
			maker.right.equalTo(-28)
			maker.top.bottom.equalTo(contentView)
		}
		accessoryImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-28)
			maker.centerY.equalTo(contentView)
			maker.left.equalTo(titleLabel.snp.right).offset(15)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTSetupModel else {
			return
		}
		titleLabel.text = model.title
		detailLabel.text = model.text
		accessoryImageView.isHidden = model.accessoryHidden ?? true
	}

    
}

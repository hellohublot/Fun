//
//  HTMineRecordCell.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineRecordCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleImageView)
		addSubview(titleLabel)
		titleImageView.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(contentView)
			maker.top.equalTo(12)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(contentView)
			maker.bottom.equalTo(-12)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineActionModel else {
			return
		}
		titleImageView.image = UIImage.init(named: model.image ?? "")
		titleLabel.text = model.title
	}
    
}

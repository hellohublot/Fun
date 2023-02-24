//
//  HTMineStoreVIPDetailHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreVIPDetailHeaderView: UICollectionReusableView, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "8a9bae4a5f18576edf7e740490474923")
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 13)
		label.textColor = UIColor.white
		label.text = "黄金VIP特权"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(backgroundImageView)
		addSubview(titleLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(10)
			maker.centerX.equalTo(self)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.bottom.centerX.equalTo(backgroundImageView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
        
}

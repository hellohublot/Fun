//
//  HTMineStorePolicyDetailHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyDetailHeaderView: UICollectionReusableView, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "111c359b21c7d229745a85898d9fcb06")
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(backgroundImageView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(10)
			maker.centerX.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}

        
}

//
//  HTMineStoreVIPDetailFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreVIPDetailFooterView: UICollectionReusableView, ReuseCell {
	
	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		return view
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
		label.font = UIFont.boldSystemFont(ofSize: 11)
		label.textColor = UIColor.init(red: 0.79, green: 0.79, blue: 0.79, alpha: 1)
		label.text = "九秀VIP"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = titleLabel.backgroundColor
		addSubview(separatorView)
		addSubview(titleLabel)
		separatorView.snp.makeConstraints { (maker) in
			maker.width.equalTo(160)
			maker.center.equalTo(self)
			maker.height.equalTo(1)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.center.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
    
}

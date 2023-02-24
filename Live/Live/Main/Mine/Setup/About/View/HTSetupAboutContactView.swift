//
//  HTSetupAboutContactView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTSetupAboutContactView: UIView {

	lazy var phoneButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(white: 0.5, alpha: 1), for: .normal)
		button.setTitle("010-64366647", for: .normal)
		return button
	}()
	
	lazy var siteButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(white: 0.5, alpha: 1), for: .normal)
		button.setTitle("访问www.9xiu.com官方网址", for: .normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(phoneButton)
		addSubview(siteButton)
		phoneButton.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
		}
		siteButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(phoneButton.snp.bottom)
			maker.bottom.left.right.equalTo(0)
			maker.height.equalTo(phoneButton)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

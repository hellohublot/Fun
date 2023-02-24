//
//  HTModifyPasswordActionView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTModifyPasswordActionView: UIView {

	lazy var sureButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitleColor(UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), for: .disabled)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 255 / 255.0, green: 47 / 255.0, blue: 88 / 255.0, alpha: 1)), for: .normal)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 199 / 255.0, green: 199 / 255.0, blue: 199 / 255.0, alpha: 1)), for: .disabled)
		button.setTitle("确认", for: .normal)
		button.layer.cornerRadius = 3
		button.layer.masksToBounds = true
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(sureButton)
		sureButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.left.equalTo(20)
			maker.right.equalTo(-20)
			maker.height.equalTo(45)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//
//  HTMineUserTabBar.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineUserTabBar: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(friendButton)
		addSubview(followButton)
		friendButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.right.equalTo(snp.centerX).offset(-20)
			maker.width.equalTo(137)
			maker.height.equalTo(45)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(friendButton)
			maker.left.equalTo(snp.centerX).offset(20)
			maker.width.height.equalTo(friendButton)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var friendButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setBackgroundImage(UIImage.init(named: "7e194deeb55694d47c64091369f6f3c1"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("添加好友", for: .normal)
		button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 6, right: 0)
		return button
	}()
	
	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setBackgroundImage(UIImage.init(named: "6bedfd004a5d8a0e0a423f3dc73e9b5f"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("已关注", for: .normal)
		button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 37, bottom: 6, right: 0)
		return button
	}()

}

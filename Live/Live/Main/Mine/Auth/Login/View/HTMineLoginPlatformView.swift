//
//  HTLoginLoginThreeView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineLoginPlatformView: UIView {
	
	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		view.layer.masksToBounds = true
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.textAlignment = .center
		label.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		label.text = "使用第三方登录"
		return label
	}()
	
	lazy var qqButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "2e2c01771faf21fd3a6b2f9ad5f6f5b1"), for: .normal)
		return button
	}()
	
	lazy var wechatButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "3d3c1e14d413fc20b94b7fb32b7145a3"), for: .normal)
		return button
	}()
	
	lazy var weiboButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "a04fb1fa0df6ee67a4265a9e3111b3d8"), for: .normal)
		return button
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.textAlignment = .center
		label.text = "登录后免费领取爱心与主播交友、聊天、互动"
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		separatorView.layer.cornerRadius = separatorView.bounds.size.height / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(separatorView)
		addSubview(titleLabel)
		addSubview(qqButton)
		addSubview(wechatButton)
		addSubview(weiboButton)
		addSubview(detailLabel)
		separatorView.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(titleLabel)
			maker.left.equalTo(40)
			maker.right.equalTo(-40)
			maker.height.equalTo(1.5)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(10)
			maker.centerX.equalTo(self)
			maker.width.equalTo(140)
		}
		qqButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(25)
			maker.left.equalTo(40)
			maker.width.height.equalTo(44)
		}
		wechatButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(qqButton)
			maker.width.height.equalTo(qqButton)
			maker.centerX.equalTo(self)
		}
		weiboButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(qqButton)
			maker.width.height.equalTo(qqButton)
			maker.right.equalTo(-40)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(qqButton.snp.bottom).offset(20)
			maker.left.equalTo(40)
			maker.right.equalTo(-40)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

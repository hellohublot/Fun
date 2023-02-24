//
//  HTLiveDetailTabbar.swift
//  Live
//
//  Created by hublot on 2019/1/6.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveDetailTabbar: UIView {

	lazy var chatButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "9d96155b976446e4de4cd7d602759301"), for: .normal)
		return button
	}()

	lazy var messageButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "c3d02b3bd1bfbab58468a42a98f829b4"), for: .normal)
		return button
	}()

	lazy var moreButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "3b27b14d74116d35bdf0191a8f0194e8"), for: .normal)
		return button
	}()

	lazy var voiceButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "77e0f23d94fc85ee7164f9665faf8d1c"), for: .normal)
		return button
	}()

	lazy var shareButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "82d150d1ccedbfa7aa1a82a8fbf3edaa"), for: .normal)
		return button
	}()

	lazy var giftButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "0d4be189767d49630f467c1beb5b2122"), for: .normal)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(chatButton)
		addSubview(messageButton)
		addSubview(moreButton)
		addSubview(voiceButton)
		addSubview(shareButton)
		addSubview(giftButton)
		chatButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.left.equalTo(10)
		}
		messageButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.left.equalTo(chatButton.snp.right).offset(10)
		}
		moreButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.left.equalTo(messageButton.snp.right).offset(10)
		}
		voiceButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.left.equalTo(moreButton.snp.right).offset(10)
		}
		shareButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.right.equalTo(giftButton.snp.left).offset(-10)
		}
		giftButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(self)
			maker.right.equalTo(-10)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

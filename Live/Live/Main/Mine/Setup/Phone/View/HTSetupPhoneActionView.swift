//
//  HTSetupPhoneActionView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTSetupPhoneActionView: UIView {

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor,
		]
		return gradientLayer
	}()
	
	lazy var sureButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		sureButton.layer.cornerRadius = sureButton.bounds.size.height / 2.0
		gradientLayer.frame = sureButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(sureButton)
		sureButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.left.equalTo(60)
			maker.right.equalTo(-60)
			maker.height.equalTo(35)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

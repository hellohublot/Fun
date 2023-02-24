//
//  HTMineForgetActionView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineForgetActionView: UIView {

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
	
	lazy var forgetButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("确认", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()
		
	override func layoutSubviews() {
		super.layoutSubviews()
		forgetButton.layer.cornerRadius = forgetButton.bounds.size.height / 2.0
		gradientLayer.frame = forgetButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(forgetButton)
		forgetButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(50)
			maker.right.equalTo(-50)
			maker.top.equalTo(0)
			maker.height.equalTo(40)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}

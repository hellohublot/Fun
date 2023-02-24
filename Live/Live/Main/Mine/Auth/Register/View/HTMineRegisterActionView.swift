//
//  HTMineRegisterActionView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineRegisterActionView: UIView {

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
	
	lazy var registerButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("立即注册", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()

	lazy var protocolButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
        let attributedString: NSAttributedString = {
            let attributedString = NSMutableAttributedString.init()
            attributedString.append(NSAttributedString.init(string: "轻触注册表示同意 ", attributes: [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
            ]))
            attributedString.append(NSAttributedString.init(string: "用户协议与隐私政策", attributes: [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
                .underlineStyle: 1
            ]))
            return attributedString
        }()
        button.setAttributedTitle(attributedString, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
        button.whenTouch(inside: { [weak self] (_, _) in
            let webController = HTWebController()
            webController.initalizeUrl = Request.url("https://www.9xiu.com/activity/agreement")
            self?.controller?.navigationController?.pushViewController(webController, animated: true)
        })

		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		registerButton.layer.cornerRadius = registerButton.bounds.size.height / 2.0
		gradientLayer.frame = registerButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(registerButton)
		addSubview(protocolButton)
		registerButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.left.equalTo(50)
			maker.right.equalTo(-50)
			maker.height.equalTo(40)
		}
		protocolButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-20)
			maker.left.equalTo(20)
			maker.right.equalTo(-20)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

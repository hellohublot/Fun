//
//  HTSetupExitCell.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupExitCell: UICollectionViewCell, ReuseCell {
	
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
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(UIColor.white, for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		button.whenTouch(inside: { [weak self] (_, _) in
			HTUserAuthManager.userToken = ""
			NotificationCenter.default.post(name: HTUserAuthManager.authStateNotification, object: nil)
			self?.controller?.navigationController?.popViewController(animated: true)
		}, receive: nil)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleButton.layer.cornerRadius = titleButton.bounds.size.height / 2.0
		gradientLayer.frame = titleButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.width.equalTo(271)
			maker.height.equalTo(38)
			maker.center.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTSetupModel else {
			return
		}
		titleButton.setTitle(model.title, for: .normal)
	}
    
}

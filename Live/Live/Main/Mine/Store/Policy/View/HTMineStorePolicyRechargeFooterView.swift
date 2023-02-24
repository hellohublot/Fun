//
//  HTMineStorePolicyRechargeFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyRechargeFooterView: UICollectionReusableView, ReuseCell {
	
	lazy var selectedLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
		label.text = "选择主播"
		return label
	}()
	
	lazy var selectedButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.setTitle("请选择主播", for: .normal)
		button.setImage(UIImage.init(named: "7ade5f2d3fb9b2b9ad9c7b3980217866"), for: .normal)
		button.layer.cornerRadius = 3
		button.layer.borderColor = UIColor.init(red: 0.847059, green: 0.847059, blue: 0.847059, alpha: 1).cgColor
		button.layer.borderWidth = 1 / UIScreen.main.scale
		button.layer.masksToBounds = true
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: -5)
		return button
	}()
	
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
	
	lazy var rechargeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("立即开通", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()
        
	override func layoutSubviews() {
		super.layoutSubviews()
		rechargeButton.layer.cornerRadius = rechargeButton.bounds.size.height / 2.0
		gradientLayer.frame = rechargeButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(selectedLabel)
		addSubview(selectedButton)
		addSubview(rechargeButton)
		selectedLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(snp.centerX).offset(-10)
			maker.top.equalTo(10)
		}
		selectedButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(selectedLabel.snp.right).offset(10)
			maker.centerY.equalTo(selectedLabel)
		}
		rechargeButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(selectedLabel.snp.bottom).offset(20)
			maker.centerX.equalTo(self)
			maker.width.equalTo(300)
			maker.height.equalTo(36)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
	
}

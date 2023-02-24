//
//  HTMineRechargeFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineRechargeFooterView: UICollectionReusableView, ReuseCell {

	lazy var convertLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.text = "(兑换比例1:700)"
		return label
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
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("确认充值", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: "首次充值免费领取VIP会员", attributes: [
				.font: UIFont.systemFont(ofSize: 10),
				.foregroundColor: UIColor.init(red: 0.101961, green: 0.101961, blue: 0.101961, alpha: 1)
			]))
			attributedString.append(NSAttributedString.init(string: "豪华大礼", attributes: [
				.font: UIFont.systemFont(ofSize: 10),
				.foregroundColor: UIColor.init(red: 1, green: 0.309804, blue: 0.305882, alpha: 1)
			]))
			return attributedString
		}()
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = rechargeButton.bounds
		rechargeButton.layer.cornerRadius = rechargeButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(convertLabel)
		addSubview(rechargeButton)
		addSubview(detailLabel)
		convertLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.right.equalTo(-15)
		}
		rechargeButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(convertLabel.snp.bottom).offset(20)
			maker.width.equalTo(335)
			maker.height.equalTo(38)
			maker.centerX.equalTo(self)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(rechargeButton.snp.bottom).offset(15)
			maker.centerX.equalTo(self)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}
        
}

//
//  HTMineStoreVIPRechargeFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreVIPRechargeFooterView: UICollectionReusableView, ReuseCell {
	
	lazy var selectedView: UIView = {
		let selectedView = UIView.init(frame: CGRect.zero)
		selectedView.layer.borderWidth = 1 / UIScreen.main.scale
		selectedView.layer.borderColor = UIColor.black.cgColor
		return selectedView
	}()
	
	lazy var selectedTitleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
		label.text = "赠送好友"
		return label
	}()
	
	lazy var numberTextField: UITextField = {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.font = UIFont.systemFont(ofSize: 13)
		textField.textColor = UIColor.black
		textField.borderStyle = .roundedRect
		textField.placeholder = "输入好友靓号"
		
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		textField.keyboardType = .numberPad
		
		let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
		textField.leftView = leftView
		textField.leftViewMode = .always
		return textField
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
		selectedView.layer.cornerRadius = selectedView.bounds.size.height / 2.0
		rechargeButton.layer.cornerRadius = rechargeButton.bounds.size.height / 2.0
		gradientLayer.frame = rechargeButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(selectedView)
		addSubview(selectedTitleLabel)
		addSubview(numberTextField)
		addSubview(rechargeButton)
		selectedTitleLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(snp.centerX).offset(-20)
			maker.top.equalTo(20)
		}
		selectedView.snp.makeConstraints { (maker) in
			maker.right.equalTo(selectedTitleLabel.snp.left).offset(-10)
			maker.centerY.equalTo(selectedTitleLabel)
			maker.width.height.equalTo(18)
		}
		numberTextField.snp.makeConstraints { (maker) in
			maker.left.equalTo(selectedTitleLabel.snp.right).offset(10)
			maker.width.equalTo(110)
			maker.height.equalTo(30)
			maker.centerY.equalTo(selectedTitleLabel)
		}
		rechargeButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(selectedTitleLabel.snp.bottom).offset(20)
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

//
//  HTDiscoverHomeSearchNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverHomeSearchNavigationBar: UIView {

	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()

	lazy var textField: UITextField = {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		textField.returnKeyType = .search
		textField.enablesReturnKeyAutomatically = true

		textField.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		textField.layer.masksToBounds = true

		let leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 45))
		leftImageView.image = UIImage.init(named: "21a7ac21a227dceca9ec64b7d78505ac")
		leftImageView.contentMode = .center
		textField.leftView = leftImageView
		textField.leftViewMode = .always

		textField.font = UIFont.systemFont(ofSize: 14)
		textField.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		textField.placeholder = "输入家族名称或者徽章名称"
		return textField
	}()

	lazy var cancelButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setTitle("取消", for: .normal)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.controller?.navigationController?.popViewController(animated: true)
		})
		return button
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		textField.layer.cornerRadius = textField.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize.init(width: 0, height: 1)
		layer.shadowOpacity = 0.05

		addSubview(navigationContentView)
		addSubview(textField)
		addSubview(cancelButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.bottom.left.right.equalTo(0)
			maker.top.equalTo(HTStatic.statusHeight)
		}
		textField.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(navigationContentView)
			maker.height.equalTo(30)
		}
		cancelButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(navigationContentView)
			maker.left.equalTo(textField.snp.right).offset(15)
			maker.width.equalTo(35)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

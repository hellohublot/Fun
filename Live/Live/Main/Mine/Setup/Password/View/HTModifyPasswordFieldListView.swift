//
//  HTModifyPasswordFieldView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTModifyPasswordFieldListView: UIView {

	func createTextField() -> UITextField {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		textField.font = UIFont.systemFont(ofSize: 12)
		textField.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		
		let leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 45))
		leftImageView.contentMode = .center
		leftImageView.image = UIImage.init(named: "45d95f72be5284bb50febf953534947a")
		textField.leftView = leftImageView
		textField.leftViewMode = .always
		
		let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 45))
        rightButton.setImage(UIImage.init(named: "3c5524285f4d0c7c0ce09d55981da25a"), for: .normal)
		rightButton.setImage(UIImage.init(named: "9016e20042878b43f46ac16c5d1d1cab"), for: .selected)
		weak var weakTextField = textField
		weak var weakRightButton = rightButton
		rightButton.whenTouch(inside: { (_, _) in
			weakRightButton?.isSelected = !(weakRightButton?.isSelected ?? false)
			weakTextField?.isSecureTextEntry = !(weakTextField?.isSecureTextEntry ?? false) 
		})
        rightButton.sendTouch()
		textField.rightView = rightButton
		textField.rightViewMode = .always
		
		textField.backgroundColor = UIColor.white
		textField.layer.masksToBounds = true
		textField.layer.cornerRadius = 3
		return textField
	}
	
	lazy var lastTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "旧密码(6-20位)"
		return textField
	}()
	
	lazy var thisTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "新密码(6-20位)"
		return textField
	}()
	
	lazy var sureTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "确认密码(6-20位)"
		return textField
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(lastTextField)
		addSubview(thisTextField)
		addSubview(sureTextField)
		lastTextField.snp.makeConstraints { (maker) in
			maker.left.equalTo(20)
			maker.top.equalTo(22)
			maker.right.equalTo(-20)
			maker.height.equalTo(45)
		}
		thisTextField.snp.makeConstraints { (maker) in
			maker.left.right.height.equalTo(lastTextField)
			maker.top.equalTo(lastTextField.snp.bottom).offset(13)
		}
		sureTextField.snp.makeConstraints { (maker) in
			maker.left.right.height.equalTo(lastTextField)
			maker.top.equalTo(thisTextField.snp.bottom).offset(13)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//
//  HTMineFieldListView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineFieldListType {
    case register
    case forget
}

class HTMineFieldListView: UIView {
    
    deinit {
        Observer.removeAll(HTPhoneCodeManager.share)
    }
    
    var fieldListType = HTMineFieldListType.register
    
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
		textField.leftView = leftImageView
		textField.leftViewMode = .always
		textField.rightViewMode = .always
		textField.backgroundColor = UIColor.white
		textField.layer.masksToBounds = true
		textField.layer.cornerRadius = 3
		return textField
	}
	
	lazy var phoneTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "请输入手机号"
		(textField.leftView as? UIImageView)?.image = UIImage.init(named: "e6886a75747e9dfcda166dcded00b634")
		return textField
	}()
	
	lazy var codeTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "请输入验证码"
		(textField.leftView as? UIImageView)?.image = UIImage.init(named: "cbb1866878a0702ce54b1865ea0f2414")
		return textField
	}()
	
	lazy var codeButton: UIButton = {
		let button = UIButton.init(type: .custom)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("获取验证码", for: .normal)
		button.setBackgroundImage(UIImage.init(named: "d50a98864a13a14fe36977847af27a0e"), for: .normal)
		button.layer.cornerRadius = 3
		button.layer.masksToBounds = true
        Observer.add(HTPhoneCodeManager.share, #selector(getter: HTPhoneCodeManager.share.phoneCodeCount), .initial, { [weak self] (codeManager, _) in
            if HTPhoneCodeManager.share.phoneCodeCount <= 0 {
                button.isEnabled = true
                button.isUserInteractionEnabled = true
            } else {
                button.isEnabled = false
                button.isUserInteractionEnabled = false
                button.setTitle("\(HTPhoneCodeManager.share.phoneCodeCount)", for: .disabled)
            }
        })
        button.whenTouch(inside: { [weak self] (_, _) in
            self?.phoneCodeButtonTouchInside()
        })
		return button
	}()
	
	lazy var passwordTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "密码(6-20位)"
		(textField.leftView as? UIImageView)?.image = UIImage.init(named: "45d95f72be5284bb50febf953534947a")
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
		return textField
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(phoneTextField)
		addSubview(codeTextField)
		addSubview(codeButton)
		addSubview(passwordTextField)
		phoneTextField.snp.makeConstraints { (maker) in
			maker.left.equalTo(20)
			maker.top.equalTo(22)
			maker.right.equalTo(-20)
			maker.height.equalTo(45)
		}
		codeTextField.snp.makeConstraints { (maker) in
			maker.left.height.equalTo(phoneTextField)
			maker.top.equalTo(phoneTextField.snp.bottom).offset(13)
			maker.right.equalTo(codeButton.snp.left).offset(-8)
		}
		codeButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-20)
			maker.top.bottom.equalTo(codeTextField)
			maker.width.equalTo(90)
		}
		passwordTextField.snp.makeConstraints { (maker) in
			maker.left.right.height.equalTo(phoneTextField)
			maker.top.equalTo(codeTextField.snp.bottom).offset(13)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    
    func phoneCodeButtonTouchInside() {
        HTPhoneCodeManager.share.requestPhoneButtonCode()
        switch fieldListType {
        case .register:
            Request.action.registerPhoneCode(phoneTextField.text ?? "") { (result) in
                self.sendPhoneCodeResponse(result)
            }
        case .forget:
            Request.action.forgetPhoneCode(phoneTextField.text ?? "") { (result) in
                self.sendPhoneCodeResponse(result)
            }
        }
    }
    
    func sendPhoneCodeResponse(_ result: Result) {
        guard let _ = result.value else {
            HTPhoneCodeManager.share.responsePhoneButtonCode(nil)
            return
        }
        codeTextField.becomeFirstResponder()
        HTPhoneCodeManager.share.responsePhoneButtonCode(60)
    }
	

}

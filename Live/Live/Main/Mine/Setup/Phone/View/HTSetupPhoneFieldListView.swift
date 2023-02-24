//
//  HTSetupPhoneFieldView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTSetupPhoneFieldListView: UIView {
    
    deinit {
        Observer.removeAll(HTPhoneCodeManager.share)
    }
    
    var type = HTSetupPhoneControllerType.bind

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
		textField.placeholder = "手机号"
		(textField.leftView as? UIImageView)?.image = UIImage.init(named: "e6886a75747e9dfcda166dcded00b634")
		return textField
	}()
	
	lazy var codeTextField: UITextField = {
		let textField = createTextField()
		textField.placeholder = "验证码"
		(textField.leftView as? UIImageView)?.image = UIImage.init(named: "cbb1866878a0702ce54b1865ea0f2414")
		return textField
	}()
	
	lazy var codeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
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
        }, receive: nil)
		return button
	}()
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(phoneTextField)
		addSubview(codeTextField)
		addSubview(codeButton)
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
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    func phoneCodeButtonTouchInside() {
        HTPhoneCodeManager.share.requestPhoneButtonCode()
        switch type {
        case .bind:
            Request.action.bindPhoneCode(phoneTextField.text ?? "") { (result) in
                self.sendPhoneCodeResponse(result)
            }
        case .cancel(let phoneString):
            Request.action.cancelPhoneCode(phoneString) { (result) in
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

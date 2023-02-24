//
//  HTMineLoginFieldView.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineLoginFieldView: UIView {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		var image = UIImage.init(named: "c985260d7d7c87798253ddd2134bbc9d")
		image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 137, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
		imageView.image = image
		return imageView
	}()
	
	lazy var contentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.cornerRadius = 5
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOffset = CGSize.init(width: 0, height: 5)
		view.layer.shadowOpacity = 0.02
		return view
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 19)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .center
		label.text = "请输入你的手机号"
		return label
	}()
	
	func createTextField() -> UITextField {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		textField.font = UIFont.systemFont(ofSize: 15)
		textField.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
		textField.leftViewMode = .always
		textField.rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
		textField.rightViewMode = .always
		textField.backgroundColor = UIColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
		textField.layer.masksToBounds = true
		textField.layer.cornerRadius = 3
		return textField
	}
	
	lazy var accountTextFiled: UITextField = {
		let textField = createTextField()
		textField.placeholder = "手机号或九秀帐号"
		return textField
	}()
	
	lazy var passwordTextFiled: UITextField = {
		let textField = createTextField()
		textField.placeholder = "密码(6-20位)"
		textField.isSecureTextEntry = true
		return textField
	}()
	
	lazy var forgetButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setTitle("忘记密码?", for: .normal)
		button.whenTouch(inside: { [weak self] (_, _) in
			let forgetController = HTMineForgetController()
			self?.controller?.navigationController?.pushViewController(forgetController, animated: true)
		})
		return button
	}()
	
	lazy var registerButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.setTitle("快速注册", for: .normal)
		button.setImage(UIImage.init(named: "ae96a1d5e564386c0921940db367f4b0"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: -3)
		button.whenTouch(inside: { [weak self] (_, _) in
			let registerController = HTMineRegisterController()
			self?.controller?.navigationController?.pushViewController(registerController, animated: true)
		})
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(contentView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(accountTextFiled)
		contentView.addSubview(passwordTextFiled)
		contentView.addSubview(forgetButton)
		contentView.addSubview(registerButton)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0))
		}
		contentView.snp.makeConstraints { (maker) in
			maker.left.equalTo(20)
			maker.top.equalTo(137)
			maker.right.equalTo(-20)
			maker.height.equalTo(209)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(20)
			maker.left.right.equalTo(0)
		}
		accountTextFiled.snp.makeConstraints { (maker) in
			maker.left.equalTo(20)
			maker.right.equalTo(-20)
			maker.top.equalTo(titleLabel.snp.bottom).offset(20)
			maker.height.equalTo(40)
		}
		passwordTextFiled.snp.makeConstraints { (maker) in
			maker.top.equalTo(accountTextFiled.snp.bottom).offset(12)
			maker.left.right.height.equalTo(accountTextFiled)
		}
		forgetButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(26)
			maker.bottom.equalTo(-10)
		}
		registerButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-26)
			maker.centerY.equalTo(forgetButton)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

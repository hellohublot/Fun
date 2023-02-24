//
//  HTRegisterController.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineRegisterController: UIViewController {

	lazy var fieldListView: HTMineFieldListView = {
		let fieldListView = HTMineFieldListView.init(frame: CGRect.zero)
        fieldListView.fieldListType = .register
		return fieldListView
	}()
	
	lazy var actionView: HTMineRegisterActionView = {
		let actionView = HTMineRegisterActionView.init(frame: CGRect.zero)
		return actionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        actionView.registerButton.whenTouch(inside: { [weak self] (_, _) in
            self?.registerButtonTouchUpInside()
        }, receive: nil)
	}
	
	func initInterface() {
		navigationItem.title = "注册账号"
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		view.addSubview(fieldListView)
		view.addSubview(actionView)
		fieldListView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(180)
		}
		actionView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(fieldListView.snp.bottom).offset(50)
		}
	}
    
    func registerButtonTouchUpInside() {
        let (accountString, codeString, passwordString) = packFieldTextList()
        let validateErrorString = validateFieldTextListErrorString((accountString, codeString, passwordString))
        guard validateErrorString.count <= 0 else {
            HTHud.showError(withStatus: validateErrorString)
            return
        }
        Request.action.registerAccount(accountString, codeString, passwordString) { (result) in
            guard let value = result.value as? [String: Any], let tokenString = value["token"] as? String, tokenString.count > 0 else {
                return
            }
            HTUserAuthManager.userToken = tokenString
            NotificationCenter.default.post(name: HTUserAuthManager.authStateNotification, object: nil)
            let navigationController = self.rt_navigationController
            let loginController = navigationController?.findController(HTMineLoginController.self)
            let beforeLoginController = navigationController?.findBeforeThisController(loginController)
            self.rt_navigationController.pop(to: beforeLoginController ?? self, animated: true, complete: { (_) in
            })
        }
    }
    
    func packFieldTextList() -> (String, String, String) {
        let accountString = fieldListView.phoneTextField.text ?? ""
        let codeString = fieldListView.codeTextField.text ?? ""
        let passwordString = fieldListView.passwordTextField.text ?? ""
        return (accountString, codeString, passwordString)
    }
    
    func validateFieldTextListErrorString(_ fieldTextList: (String, String, String)) -> String {
        let (accountString, codeString, passwordString) = fieldTextList
        guard accountString.count > 0 else {
            return "请输入手机号"
        }
        guard codeString.count > 0 else {
            return "请输入收到的短信验证码"
        }
        guard passwordString.count > 0 else {
            return "请输入你的密码"
        }
        return ""
    }

	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

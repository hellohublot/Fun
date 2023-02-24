//
//  HTLoginController.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineLoginController: UIViewController {

	lazy var fieldView: HTMineLoginFieldView = {
		let fieldView = HTMineLoginFieldView.init(frame: CGRect.zero)
		return fieldView
	}()
	
	lazy var actionView: HTMineLoginActionView = {
		let actionView = HTMineLoginActionView.init(frame: CGRect.zero)
		return actionView
	}()
	
	lazy var threeView: HTMineLoginPlatformView = {
		let threeView = HTMineLoginPlatformView.init(frame: CGRect.zero)
		return threeView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        fieldView.accountTextFiled.text = HTUserAuthManager.loginRememberAccount
		let platformLoginList = [
			threeView.qqButton: SSDKPlatformType.typeQQ,
			threeView.wechatButton: SSDKPlatformType.typeWechat,
			threeView.weiboButton: SSDKPlatformType.typeSinaWeibo
		]
		for (button, platformType) in platformLoginList {
			button.whenTouch(inside: { [weak self] (_, _) in
				HTHud.show(withStatus: "三方授权中")
				ShareSDK.loginFrom(platformType, { (success, value) in
					HTHud.dismiss()
					self?.platformLoginDidResponse(platformType, success, value)
				})
			}, receive: nil)
		}
		actionView.loginButton.whenTouch(inside: { [weak self] (_, _) in
			self?.loginButtonDidResponse()
		}, receive: nil)
	}

	func platformLoginDidResponse(_ platformType: SSDKPlatformType?, _ success: Bool, _ value: [String: Any]) {
		guard success == true else {
			HTHud.showError(withStatus: "三方授权失败")
			return
		}
		Request.action.platformLogin(platformType, value) { (result) in
			self.handlerLoginDidResponse(nil, result)
		}
	}

	func loginButtonDidResponse() {
		let (accountString, passwordString) = packFieldTextList()
		let validateErrorString = validateFieldTextListErrorString((accountString, passwordString))
		guard validateErrorString.count <= 0 else {
			HTHud.showError(withStatus: validateErrorString)
			return
		}
		Request.action.userLogin(accountString, passwordString, { (result) in
			self.handlerLoginDidResponse(accountString, result)
		})
	}

    func handlerLoginDidResponse(_ accountNameString: String?, _ result: Result) {
		guard let value = result.value as? [String: Any], let tokenString = value["token"] as? String, tokenString.count > 0 else {
			return
		}
        if let accountNameString = accountNameString, accountNameString.count > 0 {
            HTUserAuthManager.loginRememberAccount = accountNameString
        }
		HTUserAuthManager.userToken = tokenString
		NotificationCenter.default.post(name: HTUserAuthManager.authStateNotification, object: nil)
		navigationController?.popViewController(animated: true)
	}

	func packFieldTextList() -> (String, String) {
		let accountString = fieldView.accountTextFiled.text ?? ""
		let passwordString = fieldView.passwordTextFiled.text ?? ""
		return (accountString, passwordString)
	}

	func validateFieldTextListErrorString(_ fieldTextList: (String, String)) -> String {
		let (accountString, passwordString) = fieldTextList
		guard accountString.count > 0 else {
			return "请输入用户名"
		}
		guard passwordString.count > 0 else {
			return "请输入登录密码"
		}
		return ""
	}

	func initInterface() {
		navigationController?.navigationBar.setBackgroundImage(UIImage.from(UIColor.clear), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage.from(UIColor.clear)
		navigationController?.navigationBar.isTranslucent = true
		
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		
		view.addSubview(fieldView)
		view.addSubview(actionView)
		view.addSubview(threeView)
		fieldView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(346)
		}
		actionView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.equalTo(fieldView.snp.bottom).offset(50)
			maker.height.equalTo(100)
		}
		threeView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(150)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
		return UIBarButtonItem.init(image: UIImage.init(named: "98c1e876c72d8b6ece5fec12b18993fd")?.imageTintColor(UIColor.white).withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
	}

}

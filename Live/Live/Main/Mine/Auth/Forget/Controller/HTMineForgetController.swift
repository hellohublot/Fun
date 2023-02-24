//
//  HTMineForgetController.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineForgetController: UIViewController {

	lazy var fieldListView: HTMineFieldListView = {
		let fieldListView = HTMineFieldListView.init(frame: CGRect.zero)
        fieldListView.fieldListType = .forget
		return fieldListView
	}()

	lazy var actionView: HTMineForgetActionView = {
		let actionView = HTMineForgetActionView.init(frame: CGRect.zero)
		return actionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        actionView.forgetButton.whenTouch(inside: { [weak self] (_, _) in
            self?.forgetButtonTouchUpInside()
        }, receive: nil)
	}
	
	func initInterface() {
		navigationItem.title = "找回密码"
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
    
    
    func forgetButtonTouchUpInside() {
        let (accountString, codeString, passwordString) = packFieldTextList()
        let validateErrorString = validateFieldTextListErrorString((accountString, codeString, passwordString))
        guard validateErrorString.count <= 0 else {
            HTHud.showError(withStatus: validateErrorString)
            return
        }
        Request.action.forgetPassword(accountString, codeString, passwordString) { (result) in
            guard let _ = result.value else {
                return
            }
            HTHud.showSuccess(withStatus: "重置密码成功")
            self.navigationController?.popViewController(animated: true)
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
            return "请输入你要更改的密码"
        }
        return ""
    }

	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

//
//  HTSetupPhoneController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTSetupPhoneControllerType {
    case bind
    case cancel(_: String)
}

class HTSetupPhoneController: UIViewController {
    
    var type = HTSetupPhoneControllerType.bind

	lazy var fieldListView: HTSetupPhoneFieldListView = {
		let fieldListView = HTSetupPhoneFieldListView.init(frame: CGRect.zero)
        fieldListView.type = type
		return fieldListView
	}()
	
	lazy var actionView: HTSetupPhoneActionView = {
		let actionView = HTSetupPhoneActionView.init(frame: CGRect.zero)
		return actionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        switch type {
        case .bind:
            actionView.sureButton.setTitle("确认绑定", for: .normal)
        case .cancel:
            let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
            fieldListView.phoneTextField.text = {
                var userPhone = userInfoModel?.phone ?? ""
                let hiddenCount = 5
                let showCount = (userPhone.count - hiddenCount) / 2
                if showCount > 0 {
                    var hiddenString = ""
                    for _ in 0..<hiddenCount {
                        hiddenString += "*"
                    }
                    userPhone = userPhone.replacingCharacters(in: userPhone.index(userPhone.startIndex, offsetBy: showCount)..<userPhone.index(userPhone.endIndex, offsetBy: -showCount), with: hiddenString)
                }
                return userPhone
            }()
            fieldListView.phoneTextField.isEnabled = false
            actionView.sureButton.setTitle("确认解除绑定", for: .normal)
        }
        actionView.sureButton.whenTouch(inside: { [weak self] (_, _) in
            self?.sureButtonTouchUpInside()
        }, receive: nil)
	}
	
	func initInterface() {
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        switch type {
        case .bind:
            navigationItem.title = "绑定手机"
        case .cancel:
            navigationItem.title = "解除绑定手机"
        }
		view.addSubview(fieldListView)
		view.addSubview(actionView)
		fieldListView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(155)
		}
		actionView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(fieldListView.snp.bottom)
		}
	}
    
    func sureButtonTouchUpInside() {
        let (phoneString, codeString) = packFieldTextList()
        let validateErrorString = validateFieldTextListErrorString((phoneString, codeString))
        guard validateErrorString.count <= 0 else {
            HTHud.showError(withStatus: validateErrorString)
            return
        }
        switch type {
        case .bind:
            Request.action.bindPhone(phoneString, codeString) { [weak self] (result) in
                self?.sureButtonModifyPhoneResponse(result)
            }
        case .cancel(let userPhoneString):
            Request.action.cancelPhone(userPhoneString, codeString) { [weak self] (result) in
                self?.sureButtonModifyPhoneResponse(result)
            }
        }
    }
    
    func sureButtonModifyPhoneResponse(_ result: Result) {
        guard let _ = result.value else {
            return
        }
        switch type {
        case .bind:
            HTHud.showSuccess(withStatus: "绑定手机号成功")
        case .cancel:
            HTHud.showSuccess(withStatus: "解除手机号成功")
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    func packFieldTextList() -> (String, String) {
        let phoneString = fieldListView.phoneTextField.text ?? ""
        let codeString = fieldListView.codeTextField.text ?? ""
        return (phoneString, codeString)
    }
    
    func validateFieldTextListErrorString(_ fieldTextList: (String, String)) -> String {
        let (phoneString, codeString) = fieldTextList
        guard phoneString.count > 0 else {
            return "请输入手机号"
        }
        guard codeString.count > 0 else {
            return "请输入收到的短信验证码"
        }
        return ""
    }

	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

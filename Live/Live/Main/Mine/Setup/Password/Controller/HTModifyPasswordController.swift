//
//  HTModifyPasswordController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTModifyPasswordController: UIViewController {

	lazy var fieldListView: HTModifyPasswordFieldListView = {
		let fieldListView = HTModifyPasswordFieldListView.init(frame: CGRect.zero)
		return fieldListView
	}()
	
	lazy var actionView: HTModifyPasswordActionView = {
		let actionView = HTModifyPasswordActionView.init(frame: CGRect.zero)
		return actionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        actionView.sureButton.whenTouch(inside: { [weak self] (_, _) in
            self?.modifyButtonTouchUpInside()
        }, receive: nil)
	}
	
	func initInterface() {
		navigationItem.title = "修改密码"
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		view.addSubview(fieldListView)
		view.addSubview(actionView)
		fieldListView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(196)
		}
		actionView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(fieldListView.snp.bottom)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
    func modifyButtonTouchUpInside() {
        let (lastPasswordString, thisPasswordString, surePasswordString) = packFieldTextList()
        let validateErrorString = validateFieldTextListErrorString((lastPasswordString, thisPasswordString, surePasswordString))
        guard validateErrorString.count <= 0 else {
            HTHud.showError(withStatus: validateErrorString)
            return
        }
        Request.action.modifyPassword(lastPasswordString, thisPasswordString) { (result) in
            guard let _ = result.value else {
                return
            }
            HTHud.showSuccess(withStatus: "修改密码成功")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func packFieldTextList() -> (String, String, String) {
        let lastPasswordString = fieldListView.lastTextField.text ?? ""
        let thisPasswordString = fieldListView.thisTextField.text ?? ""
        let surePasswordString = fieldListView.sureTextField.text ?? ""
        return (lastPasswordString, thisPasswordString, surePasswordString)
    }
    
    func validateFieldTextListErrorString(_ fieldTextList: (String, String, String)) -> String {
        let (lastPasswordString, thisPasswordString, surePasswordString) = fieldTextList
        guard lastPasswordString.count > 0 else {
            return "请输入你的旧密码"
        }
        guard thisPasswordString.count > 0 else {
            return "请输入你的新密码"
        }
        guard surePasswordString.count > 0 else {
            return "请确认你输入的密码"
        }
        guard thisPasswordString == surePasswordString else {
            return "两次输入的密码不一致"
        }
        return ""
    }


}

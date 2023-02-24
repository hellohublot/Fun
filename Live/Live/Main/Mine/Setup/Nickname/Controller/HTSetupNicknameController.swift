//
//  HTSetupNicknameController.swift
//  Live
//
//  Created by hublot on 2019/1/22.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTSetupNicknameController: UIAlertController {
	
	static func show() {
		let alertController = UIAlertController.init(title: "修改昵称", message: nil, preferredStyle: .alert)
		alertController.addTextField { (textField) in
			let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
			textField.placeholder = "请输入要修改的新昵称"
			textField.text = userInfoModel?.nickname ?? ""
			textField.autocapitalizationType = .none
			textField.autocorrectionType = .no
			textField.spellCheckingType = .no
			textField.keyboardAppearance = .dark
			textField.clearButtonMode = .whileEditing
			textField.returnKeyType = .done
		}
		alertController.addAction(UIAlertAction.init(title: "取消", style: .default, handler: { [weak alertController] (alertAction) in
			alertController?.dismiss(animated: true, completion: nil)
		}))
		alertController.addAction(UIAlertAction.init(title: "确认", style: .default, handler: { [weak alertController] (alertAction) in
			alertController?.dismiss(animated: true, completion: nil)
		}))
		let tabbarController = Appdelegate.rootController() as? UITabBarController
        alertController.modalPresentationStyle = .fullScreen
		tabbarController?.present(alertController, animated: true, completion: { [weak alertController] in 
			alertController?.textFields?.first?.becomeFirstResponder()
		})
	}

}

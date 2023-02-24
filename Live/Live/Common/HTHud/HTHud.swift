//
//  HTHud.swift
//  Live
//
//  Created by hublot on 2018/12/27.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTHud: NSObject {
	
	static func initUserInterface() {
		SVProgressHUD.setDefaultStyle(.dark)
		SVProgressHUD.setMaximumDismissTimeInterval(2)
		SVProgressHUD.setMinimumSize(CGSize.init(width: 120, height: 120))
	}
	
	static func show(withStatus: String?) {
		initUserInterface()
		SVProgressHUD.show(withStatus: withStatus)
	}
	
	static func showSuccess(withStatus: String?) {
		initUserInterface()
		SVProgressHUD.showSuccess(withStatus: withStatus)
	}
	
	static func showError(withStatus: String?) {
		initUserInterface()
		SVProgressHUD.showError(withStatus: withStatus)
	}
	
	static func setAllowBackgroundUserInteractionEnabled(_ enable: Bool) {
		SVProgressHUD.setDefaultMaskType(enable ? .none : .clear)
	}
	
	static func dismiss() {
		SVProgressHUD.dismiss()
	}
}

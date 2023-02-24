//
//  HTUserAuthManager.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTUserAuthManager: NSObject {

	static let authStateNotification = NSNotification.Name.init("com.hublot.authStateNotification")

	static var userToken: String {
		get {
			let token = UserDefaults.standard.value(forKey: #function) as? String
			return token ?? ""
		}
		set {
			UserDefaults.standard.setValue(newValue, forKey: #function)
		}
	}

	static var userInfo: [String: Any] {
		get {
			let info = UserDefaults.standard.value(forKey: #function) as? [String: Any]
			return info ?? [String: Any]()
		}
		set {
			UserDefaults.standard.setValue(newValue, forKey: #function)
		}
	}

	static func isLogin() -> Bool {
		return userToken.count > 0
	}

	static func showLoginController() {
		let loginController = HTMineLoginController()
		Appdelegate.navigationController()?.pushViewController(loginController, animated: true)
	}
    
    static var loginRememberAccount: String {
        get {
            let rememberAccount = UserDefaults.standard.value(forKey: #function) as? String
            return rememberAccount ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }

	static func showLoginMaskView() {
		
	}

}

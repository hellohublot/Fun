//
//  HTControllerSecondAction.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

protocol HTControllerSecondReload: class {

	func secondReload() -> Bool

}

extension HTControllerSecondReload where Self: UIViewController {

	var hadReload: Bool? {
		get {
			return (associatedValueFor(key: #function) as? Bool) ?? false
		}
		set {
			setAssociatedValue(value: newValue, forKey: #function)
		}
	}

	func secondReload() -> Bool {
		if hadReload == false {
			hadReload = true
			return false
		} else {
			return true
		}
	}

}

//
//  HTSetupFriendModel.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTSetupFriendType {
	case `default`
}

class HTSetupFriendModel: NSObject {
	
	var title: String?
	var type: HTSetupFriendType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
    class func packModelArray(_ configDictionary: [String: Any]) -> [HTSetupFriendModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
        
        let configFriendString = configDictionary["friendRequestConfig"] as? String ?? ""
        
		let keyValueArray = [
			[titleKey: "允许任何人添加好友", typeKey: HTSetupFriendType.default, textKey: "1", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "仅限主播添加", typeKey: HTSetupFriendType.default, textKey: "3", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "5富以上可添加", typeKey: HTSetupFriendType.default, textKey: "4", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "不允许任何人添加好友", typeKey: HTSetupFriendType.default, textKey: "2", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTSetupFriendModel in
			let model = HTSetupFriendModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTSetupFriendType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
            
            if configFriendString == model.text {
                model.selected = true
            } else {
                model.selected = false
            }
            
			model.selectedImage = dictionary[selectedImageKey] as? String
			return model
		}
		return modelArray
	}
}

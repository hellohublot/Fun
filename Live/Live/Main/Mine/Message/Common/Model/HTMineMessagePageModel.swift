//
//  HTMineMessageModel.swift
//  Live
//
//  Created by hublot on 2019/1/9.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineMessagePageType {
	case message
	case friend
}

class HTMineMessagePageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineMessagePageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTMineMessagePageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "消息", typeKey: HTMineMessagePageType.message, textKey: "", controllerClassKey: HTMineMessageContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "好友", typeKey: HTMineMessagePageType.friend, textKey: "", controllerClassKey: HTMineMessageFriendController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineMessagePageModel in
			let model = HTMineMessagePageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineMessagePageType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			return model
		}
		return modelArray
	}
}

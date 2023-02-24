//
//  HTMineGuardPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineGuardPageType {
	case `default`
}

class HTMineGuardPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineGuardPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTMineGuardPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "我管理的直播间", typeKey: HTMineGuardPageType.default, textKey: "", controllerClassKey: HTMineGuardManagerController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "我的守护", typeKey: HTMineGuardPageType.default, textKey: "", controllerClassKey: HTMineGuardContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineGuardPageModel in
			let model = HTMineGuardPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineGuardPageType
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

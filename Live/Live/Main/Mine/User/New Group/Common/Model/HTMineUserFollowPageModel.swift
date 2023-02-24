//
//  HTMineUserFollowPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/22.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineUserFollowPageType {
	case `default`
}

class HTMineUserFollowPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineUserFollowPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray(_ uidString: String?) -> [HTMineUserFollowPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "关注的主播", typeKey: HTMineUserFollowPageType.default, textKey: "", controllerClassKey: HTMineUserFollowRadioController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "关注的用户", typeKey: HTMineUserFollowPageType.default, textKey: "", controllerClassKey: HTMineUserFollowNormalController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineUserFollowPageModel in
			let model = HTMineUserFollowPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineUserFollowPageType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.controller = model.controllerClass?.init()
			(model.controller as? HTMineUserFollowControllerAble)?.uidString = uidString ?? ""
			return model
		}
		return modelArray
	}
}

//
//  HTSetupAnimationModel.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTSetupAnimationType {
	case `default`
}

class HTSetupAnimationModel: NSObject {
	
	var title: String?
	var type: HTSetupAnimationType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTSetupAnimationModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "礼物特效", typeKey: HTSetupAnimationType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
			[titleKey: "中奖特效", typeKey: HTSetupAnimationType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
		]
		let modelArray = keyValueArray.map { dictionary -> HTSetupAnimationModel in
			let model = HTSetupAnimationModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTSetupAnimationType
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

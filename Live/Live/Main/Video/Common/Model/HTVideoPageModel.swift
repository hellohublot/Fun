//
//  HTVideoPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTVideoPageType {
	case content
	case follow
	case topic
}

class HTVideoPageModel: NSObject, HTPageModelAble {

	var title: String?
	var type: HTVideoPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var controller: UIViewController?

	class func packModelArray() -> [HTVideoPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "推荐", typeKey: HTVideoPageType.content, textKey: "", controllerClassKey: HTVideoContentController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
			[titleKey: "关注", typeKey: HTVideoPageType.follow, textKey: "", controllerClassKey: HTVideoFollowController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "话题", typeKey: HTVideoPageType.topic, textKey: "", controllerClassKey: HTVideoTopicController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTVideoPageModel in
			let model = HTVideoPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTVideoPageType
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

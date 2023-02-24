//
//  HTDiscoverNewsPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverNewsPageType {
	case `default`
}

class HTDiscoverNewsPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTDiscoverNewsPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTDiscoverNewsPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "动态广场", typeKey: HTDiscoverNewsPageType.default, textKey: "", controllerClassKey: HTDiscoverNewsContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "关注动态", typeKey: HTDiscoverNewsPageType.default, textKey: "", controllerClassKey: HTDiscoverNewsFollowController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverNewsPageModel in
			let model = HTDiscoverNewsPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverNewsPageType
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

//
//  HTDiscoverHomeCircleModel.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverHomeCircleType {
	case mine
	case rank
}

class HTDiscoverHomeCircleModel: NSObject {

	var title: String?
	var type: HTDiscoverHomeCircleType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	class func packModelArray() -> [HTDiscoverHomeCircleModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "我的家族", typeKey: HTDiscoverHomeCircleType.mine, textKey: "", controllerClassKey: UIViewController.self, imageKey: "8f5164a70dce20c6138866953f0ee1b8", selectedImageKey: "", selectedKey: false],
			[titleKey: "家族排行榜", typeKey: HTDiscoverHomeCircleType.rank, textKey: "", controllerClassKey: UIViewController.self, imageKey: "964e1d95246d58fe5f95ab3b82d62608", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeCircleModel in
			let model = HTDiscoverHomeCircleModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverHomeCircleType
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

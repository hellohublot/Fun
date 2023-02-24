//
//  HTDiscoverCircleModel.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverCircleType {
	case home
	case activity
	case game
	case rank
}

class HTDiscoverCircleModel: NSObject {
	
	var title: String?
	var type: HTDiscoverCircleType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTDiscoverCircleModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "家族", typeKey: HTDiscoverCircleType.home, textKey: "", controllerClassKey: UIViewController.self, imageKey: "a76dd40f37da7b2ddc5e393f8f0d9bfc", selectedImageKey: "", selectedKey: false],
			[titleKey: "活动", typeKey: HTDiscoverCircleType.activity, textKey: "", controllerClassKey: UIViewController.self, imageKey: "fbfeb0b0a6c5715e91f323e647630b38", selectedImageKey: "", selectedKey: false],
			[titleKey: "游戏", typeKey: HTDiscoverCircleType.game, textKey: "", controllerClassKey: UIViewController.self, imageKey: "bd6fe45827d8a8d3a99ba31dc0780260", selectedImageKey: "", selectedKey: false],
			[titleKey: "排行榜", typeKey: HTDiscoverCircleType.rank, textKey: "", controllerClassKey: UIViewController.self, imageKey: "bb6d940c68d8c3fea018cb0e7dcae418", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverCircleModel in
			let model = HTDiscoverCircleModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverCircleType
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

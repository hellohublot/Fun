//
//  HTMineStoreVIPDetailModel.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStoreVIPDetailType {
	case `default`
}

class HTMineStoreVIPDetailModel: NSObject {
	
	var title: String?
	var type: HTMineStoreVIPDetailType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTMineStoreVIPDetailModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "vip标识", typeKey: HTMineStoreVIPDetailType.default, textKey: "专属标识，彰显不同", controllerClassKey: UIViewController.self, imageKey: "a3840034c342fe3751e73626b4f2ea2e", selectedImageKey: "", selectedKey: false],
			[titleKey: "经验提升", typeKey: HTMineStoreVIPDetailType.default, textKey: "财富等级提升40000经验值", controllerClassKey: UIViewController.self, imageKey: "fe593db0ff7cd788be566f6b230d2661", selectedImageKey: "", selectedKey: false],
			[titleKey: "防踢", typeKey: HTMineStoreVIPDetailType.default, textKey: "防普通管理员踢人", controllerClassKey: UIViewController.self, imageKey: "6b073352720a7e7885552d1fdf157b69", selectedImageKey: "", selectedKey: false],
			[titleKey: "专属表情", typeKey: HTMineStoreVIPDetailType.default, textKey: "动态表情，玩出新花样", controllerClassKey: UIViewController.self, imageKey: "1ef6a607f6aa79a026a9b3f3d8c634cd", selectedImageKey: "", selectedKey: false],
			[titleKey: "进满员房", typeKey: HTMineStoreVIPDetailType.default, textKey: "可以进满员房或vip房", controllerClassKey: UIViewController.self, imageKey: "591c39dd5294efa34e3b9c32529bbf81", selectedImageKey: "", selectedKey: false],
			[titleKey: "免费飞屏", typeKey: HTMineStoreVIPDetailType.default, textKey: "每日免费飞屏15条", controllerClassKey: UIViewController.self, imageKey: "e2dda424b04ebf90dba6fe4ed73b33c3", selectedImageKey: "", selectedKey: false],
			[titleKey: "字数限制", typeKey: HTMineStoreVIPDetailType.default, textKey: "字数上限80", controllerClassKey: UIViewController.self, imageKey: "c333188385578c857f4cec7d36aac222", selectedImageKey: "", selectedKey: false],
			[titleKey: "隐身卡", typeKey: HTMineStoreVIPDetailType.default, textKey: "赠送7天隐身卡", controllerClassKey: UIViewController.self, imageKey: "4aa80333a02df393feab8fb866fc54f2", selectedImageKey: "", selectedKey: false],
			[titleKey: "20颗爱心", typeKey: HTMineStoreVIPDetailType.default, textKey: "无需等待，立即获得20颗爱心", controllerClassKey: UIViewController.self, imageKey: "2c78fd5a910b2304929a8d1e6b23785c", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreVIPDetailModel in
			let model = HTMineStoreVIPDetailModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreVIPDetailType
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

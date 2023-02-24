//
//  HTMineStorePolicyDetailModel.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStorePolicyDetailType {
	case `default`
}

class HTMineStorePolicyDetailModel: NSObject {
	
	var title: String?
	var type: HTMineStorePolicyDetailType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTMineStorePolicyDetailModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "身份标识", typeKey: HTMineStorePolicyDetailType.default, textKey: "专属标识\n彰显身份", controllerClassKey: UIViewController.self, imageKey: "7b9d65daa0abbd2860ad5977386fdee5", selectedImageKey: "", selectedKey: false],
			[titleKey: "专属进场特效", typeKey: HTMineStorePolicyDetailType.default, textKey: "炫酷进场特效\n闪亮登场", controllerClassKey: UIViewController.self, imageKey: "56773078b6c0e7ca6a601315821ebc82", selectedImageKey: "", selectedKey: false],
			[titleKey: "防踢防禁", typeKey: HTMineStorePolicyDetailType.default, textKey: "专情守护\n风雨无阻", controllerClassKey: UIViewController.self, imageKey: "715f9ae95aa5e114adf26511b02232f8", selectedImageKey: "", selectedKey: false],
			[titleKey: "专属颜色", typeKey: HTMineStorePolicyDetailType.default, textKey: "美丽如画\n只因有你", controllerClassKey: UIViewController.self, imageKey: "cd666390f98bad3fedea5ac1ae277d08", selectedImageKey: "", selectedKey: false],
			[titleKey: "私密照片", typeKey: HTMineStorePolicyDetailType.default, textKey: "私密照片\n只给你看", controllerClassKey: UIViewController.self, imageKey: "ecf077a27c85e0360d8aef51f35529b2", selectedImageKey: "", selectedKey: false],
			[titleKey: "成长值", typeKey: HTMineStorePolicyDetailType.default, textKey: "亲密成长\n倾情陪伴", controllerClassKey: UIViewController.self, imageKey: "ecf077a27c85e0360d8aef51f35529b2", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStorePolicyDetailModel in
			let model = HTMineStorePolicyDetailModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStorePolicyDetailType
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

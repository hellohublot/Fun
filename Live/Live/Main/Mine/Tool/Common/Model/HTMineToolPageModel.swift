//
//  HTMineToolPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineToolPageType {
	case all
	case seat
	case vip
	case gift
}

class HTMineToolPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineToolPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTMineToolPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "全部", typeKey: HTMineToolPageType.all, textKey: "", controllerClassKey: HTMineToolContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "座驾", typeKey: HTMineToolPageType.seat, textKey: "", controllerClassKey: HTMineToolContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "特权", typeKey: HTMineToolPageType.vip, textKey: "", controllerClassKey: HTMineToolContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "礼物", typeKey: HTMineToolPageType.gift, textKey: "", controllerClassKey: HTMineToolContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineToolPageModel in
			let model = HTMineToolPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineToolPageType
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

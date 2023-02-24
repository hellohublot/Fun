//
//  HTMineStorePageModel.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStorePageType {
	case `default`
}

class HTMineStorePageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineStorePageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTMineStorePageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "VIP", typeKey: HTMineStorePageType.default, textKey: "", controllerClassKey: HTMineStoreVIPController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "守护", typeKey: HTMineStorePageType.default, textKey: "", controllerClassKey: HTMineStorePolicyController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "座驾", typeKey: HTMineStorePageType.default, textKey: "", controllerClassKey: HTMineStoreSeatController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "道具", typeKey: HTMineStorePageType.default, textKey: "", controllerClassKey: HTMineStoreToolController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "靓号", typeKey: HTMineStorePageType.default, textKey: "", controllerClassKey: HTMineStoreNumberController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStorePageModel in
			let model = HTMineStorePageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStorePageType
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

//
//  HTMineStorePolicyBannerModel.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStorePolicyBannerType {
	case `default`
}

class HTMineStorePolicyBannerModel: NSObject {
	
	var title: String?
	var type: HTMineStorePolicyBannerType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	class func packModelArray() -> [HTMineStorePolicyBannerModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
				
		let keyValueArray = [
			[titleKey: "", typeKey: HTMineStorePolicyBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "377eef2f0155d043b283ecd767b34a7b", selectedImageKey: "", selectedKey: true],
			[titleKey: "", typeKey: HTMineStorePolicyBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "97b5c2f16ea4fb8dbf000e19d121978f", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStorePolicyBannerModel in
			let model = HTMineStorePolicyBannerModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStorePolicyBannerType
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

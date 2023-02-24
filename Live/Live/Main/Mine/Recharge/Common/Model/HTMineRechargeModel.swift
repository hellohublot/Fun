//
//  HTMineRechargeModel.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineRechargeType {
	case `default`
}

class HTMineRechargeModel: NSObject {

	var title: String?
	var type: HTMineRechargeType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	class func packModelArray() -> [HTMineRechargeModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "8400九币", typeKey: HTMineRechargeType.default, textKey: "12元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
			[titleKey: "21000九币", typeKey: HTMineRechargeType.default, textKey: "30元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "35000九币", typeKey: HTMineRechargeType.default, textKey: "50元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "68600九币", typeKey: HTMineRechargeType.default, textKey: "98元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "208600九币", typeKey: HTMineRechargeType.default, textKey: "298元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "341600九币", typeKey: HTMineRechargeType.default, textKey: "488元", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineRechargeModel in
			let model = HTMineRechargeModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineRechargeType
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

//
//  HTDiscoverHomeDetailCircleModel.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverHomeDetailCircleType {
	case rich
	case glory
	case join
    case exit
}

class HTDiscoverHomeDetailCircleModel: NSObject {

	var title: String?
	var type: HTDiscoverHomeDetailCircleType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	class func packModelArray(_ detailModel: HTDiscoverHomeDetailModel?) -> [HTDiscoverHomeDetailCircleModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		var keyValueArray = [[String: Any]]()
		keyValueArray.append(contentsOf: [
			[titleKey: "家族富豪榜", typeKey: HTDiscoverHomeDetailCircleType.rich, textKey: "", controllerClassKey: UIViewController.self, imageKey: "5acbb3dfe1269c8435c139399c5f411b", selectedImageKey: "", selectedKey: false],
			[titleKey: "家族荣耀", typeKey: HTDiscoverHomeDetailCircleType.glory, textKey: "", controllerClassKey: UIViewController.self, imageKey: "a283516772f8a40b317a3f68d746f6cb", selectedImageKey: "", selectedKey: false],
		])
		if (detailModel?.userFamilyinfo.count ?? 0) <= 0 {
			keyValueArray.append(contentsOf: [
				[titleKey: "加入家族", typeKey: HTDiscoverHomeDetailCircleType.join, textKey: "", controllerClassKey: UIViewController.self, imageKey: "a283516772f8a40b317a3f68d746f6cb", selectedImageKey: "", selectedKey: false],
			])
		} else {
			keyValueArray.append(contentsOf: [
				[titleKey: "退出家族", typeKey: HTDiscoverHomeDetailCircleType.exit, textKey: "", controllerClassKey: UIViewController.self, imageKey: "3058fee7fd0f2c10c4149af19de157d9", selectedImageKey: "", selectedKey: false],
			])
		}
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeDetailCircleModel in
			let model = HTDiscoverHomeDetailCircleModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverHomeDetailCircleType
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

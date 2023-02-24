//
//  HTMineSignModel.swift
//  Live
//
//  Created by hublot on 2019/2/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineSignType {
	case `default`
	case box
}

class HTMineSignModel: NSObject {

	var title: String?
	var detail: String?
	var type: HTMineSignType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	class func packModelArray() -> [HTMineSignModel] {
		let titleKey = "titleKey"
		let detailKey = "detailKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "第一天", typeKey: HTMineSignType.default, detailKey: "财富值", textKey: "100", controllerClassKey: UIViewController.self, imageKey: "0065cab2029ef4034d43b3823e4bc889", selectedImageKey: "", selectedKey: true],
			[titleKey: "第二天", typeKey: HTMineSignType.default, detailKey: "财富值", textKey: "100", controllerClassKey: UIViewController.self, imageKey: "0065cab2029ef4034d43b3823e4bc889", selectedImageKey: "", selectedKey: false],
			[titleKey: "第三天", typeKey: HTMineSignType.default, detailKey: "徽章3天", textKey: "", controllerClassKey: UIViewController.self, imageKey: "aefd37d60c57e5a128cdd1b764825c77", selectedImageKey: "", selectedKey: false],
			[titleKey: "第四天", typeKey: HTMineSignType.default, detailKey: "财富值", textKey: "100", controllerClassKey: UIViewController.self, imageKey: "0065cab2029ef4034d43b3823e4bc889", selectedImageKey: "", selectedKey: false],
			[titleKey: "第五天", typeKey: HTMineSignType.default, detailKey: "财富值", textKey: "100", controllerClassKey: UIViewController.self, imageKey: "0065cab2029ef4034d43b3823e4bc889", selectedImageKey: "", selectedKey: false],
			[titleKey: "第六天", typeKey: HTMineSignType.default, detailKey: "财富值", textKey: "100", controllerClassKey: UIViewController.self, imageKey: "0065cab2029ef4034d43b3823e4bc889", selectedImageKey: "", selectedKey: false],
			[titleKey: "第七天", typeKey: HTMineSignType.box, detailKey: "七天宝箱", textKey: "", controllerClassKey: UIViewController.self, imageKey: "ab381d94bed5ba7a5342bac2e82a4c6a", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineSignModel in
			let model = HTMineSignModel()
			model.title = dictionary[titleKey] as? String
			model.detail = dictionary[detailKey] as? String
			model.type = dictionary[typeKey] as? HTMineSignType
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

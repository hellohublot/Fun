//
//  HTSetupNotifyModel.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTSetupNotifyType {
	case `default`
}

class HTSetupNotifyModel: NSObject {
	
	var title: String?
	var type: HTSetupNotifyType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray(_ type: HTSetupNotifySectionType?) -> [HTSetupNotifyModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		var keyValueArray = [[String: Any]]()
		switch type {
		case .switch?:
			keyValueArray.append(contentsOf: [
				[titleKey: "震动", typeKey: HTSetupNotifyType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
				[titleKey: "响铃", typeKey: HTSetupNotifyType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
				[titleKey: "好友消息通知", typeKey: HTSetupNotifyType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
				[titleKey: "主播直播消息", typeKey: HTSetupNotifyType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			])
		case .title?:
			keyValueArray.append(contentsOf: [
				[titleKey: "你可以关闭指定的消息提醒，不再接收TA的直播消息", typeKey: HTSetupNotifyType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			])
		default:
			break
		}
		let modelArray = keyValueArray.map { dictionary -> HTSetupNotifyModel in
			let model = HTSetupNotifyModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTSetupNotifyType
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

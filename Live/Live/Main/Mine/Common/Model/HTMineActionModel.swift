//
//  HTMineActionModel.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

enum HTMineActionType {
	case message
	case task
	case sign
	case store
	case recharge
	case tool
	case video
	case badge
	case love
	case policy
	case hidden
	case service
}

class HTMineActionModel: NSObject {
	
	var title: String?
	var type: HTMineActionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var showSwitchControl: Bool?
	
	class func packModelArray(_ type: HTMineSectionType?) -> [HTMineActionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let showSwitchControlKey = "showSwitchControlKey"
		var keyValueArray = [[String: Any]]()
		switch type {
		case .record?:
			keyValueArray.append(contentsOf: [
				[titleKey: "消息", typeKey: HTMineActionType.message, textKey: "", controllerClassKey: UIViewController.self, imageKey: "2ada9a7f9f9f9a5051dbbedd5a70bd89", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "任务", typeKey: HTMineActionType.task, textKey: "", controllerClassKey: UIViewController.self, imageKey: "ad5bafe20b50de37e17c4c34839a24e6", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "签到", typeKey: HTMineActionType.sign, textKey: "", controllerClassKey: UIViewController.self, imageKey: "6ec0a0d4171ca99d3f20a6bbdf16aff0", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "商城", typeKey: HTMineActionType.store, textKey: "", controllerClassKey: UIViewController.self, imageKey: "6158200a06922b8d0cf77eda69ee7471", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
			])
		case .money?:
			keyValueArray.append(contentsOf: [
				[titleKey: "充值中心", typeKey: HTMineActionType.recharge, textKey: "0九币 • 0九点", controllerClassKey: UIViewController.self, imageKey: "700acb552d20ba0fb3d0857bc8b693d7", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "我的道具", typeKey: HTMineActionType.tool, textKey: "", controllerClassKey: UIViewController.self, imageKey: "a79dc04f161849ca51370f78f7981af6", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
			])
		case .manager?:
			keyValueArray.append(contentsOf: [
				[titleKey: "小视频", typeKey: HTMineActionType.video, textKey: "", controllerClassKey: UIViewController.self, imageKey: "c38707b136f3d2b50082e60a0108c4c0", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "我的徽章", typeKey: HTMineActionType.badge, textKey: "", controllerClassKey: UIViewController.self, imageKey: "84666f5a1644e5ec59c64770c44a7e4c", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "真爱主播", typeKey: HTMineActionType.love, textKey: "", controllerClassKey: UIViewController.self, imageKey: "dcf5c72c7aefb163e09296dc49c91048", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "守护/管理", typeKey: HTMineActionType.policy, textKey: "", controllerClassKey: UIViewController.self, imageKey: "5e9b35c15edd737ec5f89bc4dc38cc5e", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
				[titleKey: "隐身", typeKey: HTMineActionType.hidden, textKey: "有效期:175358天", controllerClassKey: UIViewController.self, imageKey: "61f0b3e36a175951fc5859e707ecdc84", selectedImageKey: "", selectedKey: true, showSwitchControlKey: true],
			])
		case .service?:
			keyValueArray.append(contentsOf: [
				[titleKey: "客服中心", typeKey: HTMineActionType.service, textKey: "", controllerClassKey: UIViewController.self, imageKey: "6e4600370c72b4d7d76e77fe9ce2fbc2", selectedImageKey: "", selectedKey: false, showSwitchControlKey: false],
			])
		default:
			break
		}
		let modelArray = keyValueArray.map { dictionary -> HTMineActionModel in
			let model = HTMineActionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineActionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.showSwitchControl = dictionary[showSwitchControlKey] as? Bool
			return model
		}
		return modelArray
	}
}

//
//  HTMineMessageContentModel.swift
//  Live
//
//  Created by hublot on 2019/1/9.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineMessageContentType {
	case `default`
}

class HTMineMessageContentModel: NSObject {
	
	var title: String?
	var type: HTMineMessageContentType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var detail: String?
	var time: String?
	
	class func packModelArray() -> [HTMineMessageContentModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		
		let detailKey = "detailKey"
		let timeKey = "timeKey"
		let keyValueArray = [
			[titleKey: "系统消息", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "", timeKey: "15:02"],
			[titleKey: "活动中心", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "", timeKey: "15:02"],
			[titleKey: "开播提醒", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "", timeKey: "15:02"],
			[titleKey: "互动通知", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "", timeKey: "15:02"],
			[titleKey: "hublot", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "1.凡涉及淫秽色情、涉政、欺诈、侵权等信息。2.声称官方人员、官方合作方或是个人向您出售九币的行为，均为欺诈行为。3.任何私下交易导致的损失，官方概不负责。4.遇到以上任何情况可点击右上角选择“举报”", timeKey: ""],
			[titleKey: "好友请求", typeKey: HTMineMessageContentType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailKey: "hublot请求加你为好友", timeKey: ""],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineMessageContentModel in
			let model = HTMineMessageContentModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineMessageContentType
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

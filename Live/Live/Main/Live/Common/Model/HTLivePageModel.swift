//
//  HTLivePageModel.swift
//  Live
//
//  Created by hublot on 2018/12/26.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

enum HTLivePageType {
	case follow
	case hot
	case near
	case content(_: String, _: CGFloat)
}

class HTLivePageModel: NSObject, HTPageModelAble {
	var title: String?
	var type: HTLivePageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	var controller: UIViewController?
	
	class func packModelArray() -> [HTLivePageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "关注", typeKey: HTLivePageType.follow, textKey: "", controllerClassKey: HTLiveFollowController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "热门", typeKey: HTLivePageType.hot, textKey: "", controllerClassKey: HTLiveHotController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "附近", typeKey: HTLivePageType.near, textKey: "", controllerClassKey: HTLiveNearController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			
			[titleKey: "PK", typeKey: HTLivePageType.content("16", 200), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "新人", typeKey: HTLivePageType.content("17", 200), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "游戏", typeKey: HTLivePageType.content("4", 160), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "热舞", typeKey: HTLivePageType.content("2", 200), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "好声音", typeKey: HTLivePageType.content("3", 200), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "畅聊", typeKey: HTLivePageType.content("1", 200), textKey: "", controllerClassKey: HTLiveContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTLivePageModel in
			let model = HTLivePageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTLivePageType
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

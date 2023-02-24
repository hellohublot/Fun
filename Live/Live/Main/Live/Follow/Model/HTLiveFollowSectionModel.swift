//
//  HTLiveFollowSectionModel.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTLiveFollowSectionType {
	case follow
	case recommend
}

class HTLiveFollowSectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTLiveFollowSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
    
    var showDetailButton = false

	var modelArray = [Any]()

	class func packModelArray(_ value: [String: Any]) -> [HTLiveFollowSectionModel] {
		let followModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: value["follow"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
		let recommendModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: value["recommend"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
        let showDetailButtonKey = "showDetailButtonKey"
		let keyValueArray = [
            [titleKey: "已关注", typeKey: HTLiveFollowSectionType.follow, textKey: "", controllerClassKey: UIViewController.self, imageKey: "8b9d22497188abff74a61ef2bdde85aa", selectedImageKey: "", selectedKey: false, showDetailButtonKey: true],
            [titleKey: "为你推荐", typeKey: HTLiveFollowSectionType.recommend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "e7e515327de7d0e072f54aad4c7692b3", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTLiveFollowSectionModel in
			let model = HTLiveFollowSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTLiveFollowSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
            model.showDetailButton = dictionary[showDetailButtonKey] as? Bool ?? false
			switch model.type {
			case .follow?:
				model.modelArray = followModelArray
			case .recommend?:
				model.modelArray = recommendModelArray
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

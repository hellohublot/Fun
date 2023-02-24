//
//  HTLiveSearchPlaceholderSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTLiveSearchPlaceholderSectionType {
	case history
	case recommend
}

class HTLiveSearchPlaceholderSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTLiveSearchPlaceholderSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	var showClearButton: Bool?
	
	class func packModelArray(_ value: [Any]) -> [HTLiveSearchPlaceholderSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let showClearButtonKey = "showClearButtonKey"
		let keyValueArray = [
			[titleKey: "搜索历史", typeKey: HTLiveSearchPlaceholderSectionType.history, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showClearButtonKey: true],
			[titleKey: "大家都在看", typeKey: HTLiveSearchPlaceholderSectionType.recommend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showClearButtonKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTLiveSearchPlaceholderSectionModel in
			let model = HTLiveSearchPlaceholderSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTLiveSearchPlaceholderSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.showClearButton = dictionary[showClearButtonKey] as? Bool
			switch model.type {
			case .history?:
				model.modelArray = HTLiveSearchPlaceholderHistoryModel.packModelArray()
			case .recommend?:
				let recommendModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
				model.modelArray = recommendModelArray
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

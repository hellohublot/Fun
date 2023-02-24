//
//  HTMineUserInfoSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineUserInfoSectionType {
	case main
	case like
}

class HTMineUserInfoSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTMineUserInfoSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray(_ value: [String: Any]) -> [HTMineUserInfoSectionModel] {
		let infoModel = HTMineUserDetailModel.mj_object(withKeyValues: value)
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "个人信息", typeKey: HTMineUserInfoSectionType.main, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineUserInfoSectionType.like, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineUserInfoSectionModel in
			let model = HTMineUserInfoSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineUserInfoSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .main?:
				model.modelArray = HTMineUserDisplayModel.packModelArray(model.type, infoModel)
			case .like?:
				model.modelArray = HTMineUserDisplayModel.packModelArray(model.type, infoModel)
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

//
//  HTMineStoreSeatSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineStoreSeatSectionType {
	case recommend
	case page
}

class HTMineStoreSeatSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTMineStoreSeatSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var pageModelArray = [HTMineStoreSeatPageModel]()
	
	var modelArray = [Any]()
	
	class func packModelArray(_ value: [String: Any], _ pageSelectedIndex: Int) -> [HTMineStoreSeatSectionModel] {
		let recommendTitle = "推荐座驾"
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: recommendTitle, typeKey: HTMineStoreSeatSectionType.recommend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreSeatSectionType.page, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],			
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreSeatSectionModel in
			let model = HTMineStoreSeatSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreSeatSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .recommend?:
				model.modelArray = [HTMineStoreSeatModel.mj_objectArray(withKeyValuesArray: value[recommendTitle]) as? [HTMineStoreSeatModel] ?? [HTMineStoreSeatModel]()]
			case .page?:
				for (key, list) in value {
					if key != recommendTitle {
						let pageModel = HTMineStoreSeatPageModel.init()
						pageModel.title = key
						pageModel.modelArray = HTMineStoreSeatModel.mj_objectArray(withKeyValuesArray: list) as? [HTMineStoreSeatModel] ?? [HTMineStoreSeatModel]()
						model.pageModelArray.append(pageModel)
					}
				}
				model.pageModelArray.first?.selected = true
				model.modelArray = model.pageModelArray.first?.modelArray ?? [HTMineStoreSeatModel]()
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

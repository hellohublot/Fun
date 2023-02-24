//
//  HTDiscoverRankContentSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTDiscoverRankContentSectionType {
	case header
	case normal
}

class HTDiscoverRankContentSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTDiscoverRankContentSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray(_ pageModel: HTDiscoverRankPageModel?, _ value: [String: Any]) -> [HTDiscoverRankContentSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
        
        let listValue = value[HTDiscoverRankPopModel.findSelectedModel(pageModel?.rankPopModelArray)?.type?.rawValue ?? ""]
		
		var rankModelArray = HTDiscoverRankContentModel.mj_objectArray(withKeyValuesArray: listValue) as? [HTDiscoverRankContentModel] ?? [HTDiscoverRankContentModel]()
		
		if rankModelArray.count == 0 {
			return [HTDiscoverRankContentSectionModel]()
		} else if rankModelArray.count == 1 {
			let placeHolderModel = HTDiscoverRankContentModel()
			placeHolderModel.placeHolder = true
			rankModelArray.append(placeHolderModel)
		}
		
		let secondModel = rankModelArray[1]
		rankModelArray[1] = rankModelArray[0]
		rankModelArray[0] = secondModel
		
		var headerModelArray = [HTDiscoverRankContentModel]()
		var normalModelArray = [HTDiscoverRankContentModel]()
		for (index, model) in rankModelArray.enumerated() {
			model.pageType = pageModel?.type
			if index < 3 {
				headerModelArray.append(model)
			} else {
				normalModelArray.append(model)				
			}
		}
		
		let keyValueArray = [
			[titleKey: "", typeKey: HTDiscoverRankContentSectionType.header, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTDiscoverRankContentSectionType.normal, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverRankContentSectionModel in
			let model = HTDiscoverRankContentSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverRankContentSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .header?:
				model.modelArray = headerModelArray
			case .normal?:
				model.modelArray = normalModelArray
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

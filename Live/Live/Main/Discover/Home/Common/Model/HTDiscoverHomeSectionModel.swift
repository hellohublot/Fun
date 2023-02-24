//
//  HTDiscoverHomeSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTDiscoverHomeSectionType {
	case circle
	case recommend
}

class HTDiscoverHomeSectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTDiscoverHomeSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var modelArray = [Any]()

	class func packModelArray(_ recommendModelArray: [Any]) -> [HTDiscoverHomeSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTDiscoverHomeSectionType.circle, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "推荐家族", typeKey: HTDiscoverHomeSectionType.recommend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "e7e515327de7d0e072f54aad4c7692b3", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeSectionModel in
			let model = HTDiscoverHomeSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverHomeSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .circle?:
				model.modelArray = HTDiscoverHomeCircleModel.packModelArray()
			case .recommend?:
				let modelArray = recommendModelArray as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
				model.modelArray = modelArray
			default:
				break
			}
			return model
		}
		return modelArray
	}


	class func findModelArrayWithType(_ sectionModelArray: [Any], _ sectionType: HTDiscoverHomeSectionType?) -> [Any] {
		guard let modelArray = sectionModelArray as? [HTDiscoverHomeSectionModel] else {
			return [Any]()
		}
		for model in modelArray {
			if model.type == sectionType {
				return model.modelArray
			}
		}
		return [Any]()
	}

}

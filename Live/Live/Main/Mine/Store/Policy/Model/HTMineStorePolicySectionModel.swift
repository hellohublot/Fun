//
//  HTMineStorePolicySectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineStorePolicySectionType {
	case banner
	case recharge
	case detail
}

class HTMineStorePolicySectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTMineStorePolicySectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray() -> [HTMineStorePolicySectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTMineStorePolicySectionType.banner, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStorePolicySectionType.recharge, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStorePolicySectionType.detail, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStorePolicySectionModel in
			let model = HTMineStorePolicySectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStorePolicySectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .banner?:
				model.modelArray = [HTMineStorePolicyBannerModel.packModelArray()]
			case .recharge?:
				model.modelArray = HTMineStorePolicyRechargeModel.packModelArray()
			case .detail?:
				model.modelArray = HTMineStorePolicyDetailModel.packModelArray()
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

//
//  HTMineStoreVIPSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineStoreVIPSectionType {
	case banner
	case recharge
	case detail
}

class HTMineStoreVIPSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTMineStoreVIPSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray() -> [HTMineStoreVIPSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTMineStoreVIPSectionType.banner, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreVIPSectionType.recharge, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreVIPSectionType.detail, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreVIPSectionModel in
			let model = HTMineStoreVIPSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreVIPSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .banner?:
				model.modelArray = [HTMineStoreVIPBannerModel.packModelArray()]
			case .recharge?:
				model.modelArray = HTMineStoreVIPRechargeModel.packModelArray()
			case .detail?:
				model.modelArray = HTMineStoreVIPDetailModel.packModelArray()
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

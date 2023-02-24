//
//  HTSetupNotifySectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTSetupNotifySectionType {
	case `switch`
	case title
}

class HTSetupNotifySectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTSetupNotifySectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray() -> [HTSetupNotifySectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTSetupNotifySectionType.switch, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTSetupNotifySectionType.title, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTSetupNotifySectionModel in
			let model = HTSetupNotifySectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTSetupNotifySectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.modelArray = HTSetupNotifyModel.packModelArray(model.type)
			return model
		}
		return modelArray
	}
}

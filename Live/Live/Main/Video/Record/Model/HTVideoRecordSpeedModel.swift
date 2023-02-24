//
//  HTVideoRecordSpeedModel.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTVideoRecordSpeedType {
	case `default`
}

class HTVideoRecordSpeedModel: NSObject {
	
	var title: String?
	var type: HTVideoRecordSpeedType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var speedValue: CGFloat?
	
	class func packModelArray() -> [HTVideoRecordSpeedModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		
		let speedValueKey = ""
		let keyValueArray = [
			[titleKey: "极慢", typeKey: HTVideoRecordSpeedType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, speedValueKey: 0.25],
			[titleKey: "慢", typeKey: HTVideoRecordSpeedType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, speedValueKey: 0.5],
			[titleKey: "标准", typeKey: HTVideoRecordSpeedType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, speedValueKey: 1],
			[titleKey: "快", typeKey: HTVideoRecordSpeedType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, speedValueKey: 1.5],
			[titleKey: "极快", typeKey: HTVideoRecordSpeedType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, speedValueKey: 2],
		]
		let modelArray = keyValueArray.map { dictionary -> HTVideoRecordSpeedModel in
			let model = HTVideoRecordSpeedModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTVideoRecordSpeedType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.speedValue = dictionary[speedValueKey] as? CGFloat
			return model
		}
		return modelArray
	}
}

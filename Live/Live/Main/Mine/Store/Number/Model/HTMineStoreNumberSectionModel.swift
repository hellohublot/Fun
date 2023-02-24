//
//  HTMineStoreNumberSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTMineStoreNumberSectionType {
	case `default`
}

class HTMineStoreNumberSectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTMineStoreNumberSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var pageModelArray = [HTMineStoreNumberPageModel]()

	var modelArray = [Any]()

	class func packModelArray(_ value: [String: Any], _ pageSelectedIndex: Int) -> [HTMineStoreNumberSectionModel] {
		let numberTitleKey = "titleKey"
		let numberTextColorKey = "numberTextColorKey"
		let numberColorListKey = "colorListKey"
		let numberKeyValueList = [
			"3": [numberTitleKey: "三", numberTextColorKey: UIColor.init(red: 1, green: 0.45, blue: 0.55, alpha: 1), numberColorListKey: [UIColor.init(red: 1, green: 0.607843, blue: 0.568627, alpha: 1).cgColor, UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1).cgColor]],
			"4": [numberTitleKey: "四", numberTextColorKey: UIColor.init(red: 1, green: 0.65, blue: 0.41, alpha: 1), numberColorListKey: [UIColor.init(red: 1, green: 0.8, blue: 0.490196, alpha: 1).cgColor, UIColor.init(red: 1, green: 0.592157, blue: 0.372549, alpha: 1).cgColor]],
			"5": [numberTitleKey: "五", numberTextColorKey: UIColor.init(red: 0.47, green: 0.66, blue: 1, alpha: 1), numberColorListKey: [UIColor.init(red: 0.411765, green: 0.772549, blue: 1, alpha: 1).cgColor, UIColor.init(red: 0.490196, green: 0.560784, blue: 1, alpha: 1).cgColor]],
			"6": [numberTitleKey: "六", numberTextColorKey: UIColor.init(red: 0.08, green: 0.84, blue: 0.96, alpha: 1), numberColorListKey: [UIColor.init(red: 0.027451, green: 0.968627, blue: 0.933333, alpha: 1).cgColor, UIColor.init(red: 0.105882, green: 0.756863, blue: 0.968627, alpha: 1).cgColor]],
			"7": [numberTitleKey: "七", numberTextColorKey: UIColor.init(red: 0.69, green: 0.47, blue: 1, alpha: 1), numberColorListKey: [UIColor.init(red: 0.635294, green: 0.490196, blue: 1, alpha: 1).cgColor, UIColor.init(red: 0.756863, green: 0.372549, blue: 1, alpha: 1).cgColor]],
			"8": [numberTitleKey: "八", numberTextColorKey: UIColor.init(red: 0.69, green: 0.47, blue: 1, alpha: 1), numberColorListKey: [UIColor.init(red: 0.635294, green: 0.490196, blue: 1, alpha: 1).cgColor, UIColor.init(red: 0.756863, green: 0.372549, blue: 1, alpha: 1).cgColor]],
			"9": [numberTitleKey: "九", numberTextColorKey: UIColor.init(red: 0.69, green: 0.47, blue: 1, alpha: 1), numberColorListKey: [UIColor.init(red: 0.635294, green: 0.490196, blue: 1, alpha: 1).cgColor, UIColor.init(red: 0.756863, green: 0.372549, blue: 1, alpha: 1).cgColor]]
		]

		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTMineStoreNumberSectionType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreNumberSectionModel in
			let model = HTMineStoreNumberSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreNumberSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			switch model.type {
			case .default?:
				for (key, list) in value {
					let pageModel = HTMineStoreNumberPageModel.init()
					pageModel.id = key
					pageModel.title = (numberKeyValueList[key]?[numberTitleKey] as? String ?? "") + "位号"
					let textColor = numberKeyValueList[key]?[numberTextColorKey] as? UIColor ?? UIColor.clear
					let colorList = numberKeyValueList[key]?[numberColorListKey] as? [CGColor] ?? [CGColor]()
					pageModel.modelArray = HTMineStoreNumberModel.mj_objectArray(withKeyValuesArray: list) as? [HTMineStoreNumberModel] ?? [HTMineStoreNumberModel]()
					for numberModel in pageModel.modelArray {
						numberModel.textColor = textColor
						numberModel.colorList = colorList
					}
					model.pageModelArray.append(pageModel)
				}
				model.pageModelArray.sort(by: { (this, that) -> Bool in
					return this.id.compare(that.id) == .orderedAscending
				})
				model.pageModelArray[pageSelectedIndex].selected = true
				model.modelArray = model.pageModelArray[pageSelectedIndex].modelArray
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

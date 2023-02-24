//
//  HTMineUserDisplayModel.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineUserDisplayType {
	case `default`
}

class HTMineUserDisplayModel: NSObject {
	
	var title: String?
	var type: HTMineUserDisplayType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray(_ sectionType: HTMineUserInfoSectionType?, _ infoModel: HTMineUserDetailModel?) -> [HTMineUserDisplayModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		var keyValueArray = [[String: Any]]()
		
		var userSexString = "保密"
		switch infoModel?.sex {
		case "1":
			userSexString = "男"
		case "2":
			userSexString = "女"
		default:
			break
		}
		
		var userBirthString = ""
		if (infoModel?.birthday ?? 0) > 0 {
			let userBirthDate = Date.init(timeIntervalSince1970: Double(infoModel?.birthday ?? 0))
			let formatter = DateFormatter.init()
			formatter.dateFormat = "yyyy年MM月dd日"
			userBirthString = formatter.string(from: userBirthDate)
		}
		
		switch sectionType {
		case .main?:
			keyValueArray.append(contentsOf: [
				[titleKey: "性别", typeKey: HTMineUserDisplayType.default, textKey: userSexString, controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "生日", typeKey: HTMineUserDisplayType.default, textKey: userBirthString, controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "星座", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.horoscope, "保密"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "家乡", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.hometown, "主播来自火星"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "特长", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.speciality, "主播未设置"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			])
		case .like?:
			keyValueArray.append(contentsOf: [
				[titleKey: "喜欢的颜色", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.favColor, "主播未设置"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "喜欢的音乐", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.favMusic, "主播未设置"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "喜欢的明星", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.favStar, "主播未设置"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
				[titleKey: "喜欢的美食", typeKey: HTMineUserDisplayType.default, textKey: placeholderString(infoModel?.favFood, "主播未设置"), controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			])
		default:
			break
		}
		let modelArray = keyValueArray.map { dictionary -> HTMineUserDisplayModel in
			let model = HTMineUserDisplayModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineUserDisplayType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			return model
		}
		return modelArray
	}
	
	
	class func placeholderString(_ maybeString: String?, _ placeholderString: String?) -> String {
		if let maybeString = maybeString, maybeString.count > 0 {
			return maybeString
		}
		if let placeholderString = placeholderString, placeholderString.count > 0 {
			return placeholderString
		}
		return ""
	}
	
}

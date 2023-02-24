//
//  HTDiscoverHomeDetailSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTDiscoverHomeDetailSectionType {
	case info
	case circle
	case radio
	case leader
	case member
	case short
}

class HTDiscoverHomeDetailSectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTDiscoverHomeDetailSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var showDetailButton = false

	var detailModel: HTDiscoverHomeDetailModel?

	var modelArray = [Any]()

	class func packModelArray(_ detailModel: HTDiscoverHomeDetailModel) -> [HTDiscoverHomeDetailSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"

		let showDetailButtonKey = "showDetailButtonKey"

		let keyValueArray = [
			[titleKey: "", typeKey: HTDiscoverHomeDetailSectionType.info, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
			[titleKey: "", typeKey: HTDiscoverHomeDetailSectionType.circle, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
			[titleKey: "主播", typeKey: HTDiscoverHomeDetailSectionType.radio, textKey: "", controllerClassKey: UIViewController.self, imageKey: "f51b5df5dd91578ba8283131d959ce29", selectedImageKey: "", selectedKey: false, showDetailButtonKey: true],
			[titleKey: "族长", typeKey: HTDiscoverHomeDetailSectionType.leader, textKey: "", controllerClassKey: UIViewController.self, imageKey: "79b77b4bea4657bfc91d6658dfa6e8d3", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
			[titleKey: "成员", typeKey: HTDiscoverHomeDetailSectionType.member, textKey: "", controllerClassKey: UIViewController.self, imageKey: "60baaccaea414e20cd8145582013efcf", selectedImageKey: "", selectedKey: false, showDetailButtonKey: true],
			[titleKey: "简介", typeKey: HTDiscoverHomeDetailSectionType.short, textKey: "", controllerClassKey: UIViewController.self, imageKey: "07017ac6d3b6eea7adc2016e5ca491bc", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeDetailSectionModel in
			let model = HTDiscoverHomeDetailSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverHomeDetailSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.showDetailButton = dictionary[showDetailButtonKey] as? Bool ?? false

			model.detailModel = detailModel
			switch model.type {
			case .info?:
				model.modelArray = [detailModel]
			case .circle?:
				model.modelArray = HTDiscoverHomeDetailCircleModel.packModelArray(detailModel)
			case .radio?:
				model.modelArray = detailModel.anchorList
			case .leader?:
				if let leaderInfo = detailModel.leaderInfo {
					model.modelArray = [leaderInfo]
				}
			case .member?:
				model.modelArray = [detailModel.memberList]
			case .short?:
				model.modelArray = [detailModel]
			default:
				break
			}
			return model
		}
		return modelArray
	}
}

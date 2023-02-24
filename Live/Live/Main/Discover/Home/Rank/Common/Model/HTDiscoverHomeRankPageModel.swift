//
//  HTDiscoverHomeRankPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverHomeRankPageType: String {
	case money = "0"
	case star = "1"
	case rich = "2"
}

class HTDiscoverHomeRankPageModel: NSObject, HTPageModelAble {

	var title: String?
	var type: HTDiscoverHomeRankPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
    
    var rankPopModelArray = [HTDiscoverRankPopModel]()

	var controller: UIViewController?

	var showSelectedView: Bool?

	class func packModelArray() -> [HTDiscoverHomeRankPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"

		let showSelectedViewKey = "showSelectedViewKey"

		let keyValueArray = [
			[titleKey: "家族消费榜", typeKey: HTDiscoverHomeRankPageType.money, textKey: "", controllerClassKey: HTDiscoverHomeRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showSelectedViewKey: true],
			[titleKey: "优秀主播榜", typeKey: HTDiscoverHomeRankPageType.star, textKey: "", controllerClassKey: HTDiscoverHomeRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showSelectedViewKey: false],
			[titleKey: "富豪成员榜", typeKey: HTDiscoverHomeRankPageType.rich, textKey: "", controllerClassKey: HTDiscoverHomeRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showSelectedViewKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverHomeRankPageModel in
			let model = HTDiscoverHomeRankPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverHomeRankPageType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.showSelectedView = dictionary[showSelectedViewKey] as? Bool
            switch model.type {
            case .money?:
                model.rankPopModelArray = HTDiscoverRankPopModel.packModelArray(.home)
            default:
                break
            }
			return model
		}
		return modelArray
	}
}

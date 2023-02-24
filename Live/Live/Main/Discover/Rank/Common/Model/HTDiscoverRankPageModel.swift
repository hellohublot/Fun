//
//  HTDiscoverRankPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverRankPageType {
	case star
	case rich
	case pk
	case charm
}

class HTDiscoverRankPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTDiscoverRankPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
    
    var rankPopModelArray = [HTDiscoverRankPopModel]()
	
	var controller: UIViewController?
	
	class func packModelArray() -> [HTDiscoverRankPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "明星排行榜", typeKey: HTDiscoverRankPageType.star, textKey: "", controllerClassKey: HTDiscoverRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "富豪排行榜", typeKey: HTDiscoverRankPageType.rich, textKey: "", controllerClassKey: HTDiscoverRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "PK排行榜", typeKey: HTDiscoverRankPageType.pk, textKey: "", controllerClassKey: HTDiscoverRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "魅力排行榜", typeKey: HTDiscoverRankPageType.charm, textKey: "", controllerClassKey: HTDiscoverRankContentController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverRankPageModel in
			let model = HTDiscoverRankPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverRankPageType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
            switch model.type {
            case .star?, .rich?:
                model.rankPopModelArray = HTDiscoverRankPopModel.packModelArray(.default)
            case .pk?:
                model.rankPopModelArray = HTDiscoverRankPopModel.packModelArray(.pk)
            case .charm?:
                model.rankPopModelArray = HTDiscoverRankPopModel.packModelArray(.charm)
            default:
                break
            }
			return model
		}
		return modelArray
	}
}

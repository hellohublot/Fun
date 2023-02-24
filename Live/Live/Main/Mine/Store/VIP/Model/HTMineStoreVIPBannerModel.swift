//
//  HTMineStoreVIPBannerModel.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStoreVIPBannerType {
	case `default`
}

class HTMineStoreVIPBannerModel: NSObject {
	
	var title: String?
	var type: HTMineStoreVIPBannerType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTMineStoreVIPBannerModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTMineStoreVIPBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "5b889252be92f5a84f19d54ac1580b08", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreVIPBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "284e0cc97ade5937fbd37d8153fe0e3e", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreVIPBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "54fdbc92b452f7530b8878e76e2e8b74", selectedImageKey: "", selectedKey: false],
			[titleKey: "", typeKey: HTMineStoreVIPBannerType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "5afc09610fb0db496041f37269b43d56", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreVIPBannerModel in
			let model = HTMineStoreVIPBannerModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreVIPBannerType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			return model
		}
		return modelArray
	}
}

//
//  HTMineUserPageModel.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineUserPageType {
	case news
	case photo
	case video
	case info
}

class HTMineUserPageModel: NSObject, HTPageModelAble {
	
	var title: String?
	var type: HTMineUserPageType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var controller: UIViewController?
	
	class func packModelArray(_ uidString: String?) -> [HTMineUserPageModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "动态", typeKey: HTMineUserPageType.news, textKey: "", controllerClassKey: HTMineUserNewsController.self, imageKey: "", selectedImageKey: "", selectedKey: true],
			[titleKey: "相册", typeKey: HTMineUserPageType.photo, textKey: "", controllerClassKey: HTMineUserPhotoController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "视频", typeKey: HTMineUserPageType.video, textKey: "", controllerClassKey: HTMineUserVideoController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
			[titleKey: "资料", typeKey: HTMineUserPageType.info, textKey: "", controllerClassKey: HTMineUserInfoController.self, imageKey: "", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineUserPageModel in
			let model = HTMineUserPageModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineUserPageType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String


			model.controller = model.controllerClass?.init()
			(model.controller as? HTMineUserContentControllerAble)?.uidString = uidString ?? ""
			return model
		}
		return modelArray
	}
}

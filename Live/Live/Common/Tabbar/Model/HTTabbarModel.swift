//
//  HTTabbarModel.swift
//  Tian
//
//  Created by hublot on 2018/11/19.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

enum HTTabbarType {
	case live
	case video
	case discover
	case mine
}

class HTTabbarModel: NSObject {
	
	var title: String?
	var type: HTTabbarType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	class func packModelArray() -> [HTTabbarModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
            [titleKey: "直播", typeKey: HTTabbarType.live, textKey: "", controllerClassKey: HTLiveController.self, imageKey: "55de3c0c956cf20c1dc8d5a558e1da69", selectedImageKey: "434b9129fdd2a048eb2b8183a848e3a4", selectedKey: false],
            [titleKey: "视频", typeKey: HTTabbarType.video, textKey: "", controllerClassKey: HTVideoController.self, imageKey: "8fb5ddbbabb6e1b79dcdd404e411f43d", selectedImageKey: "e794dbefee8878eeb2d90d3aa5b5f25a", selectedKey: false],
            [titleKey: "发现", typeKey: HTTabbarType.discover, textKey: "", controllerClassKey: HTDiscoverController.self, imageKey: "059870a366690061d29e97f6df4250b0", selectedImageKey: "7374e53be81e10d97f24df8fe87432e6", selectedKey: false],
            [titleKey: "我的", typeKey: HTTabbarType.mine, textKey: "", controllerClassKey: HTMineController.self, imageKey: "53c18a7730544ea7fc83d3a0156c8087", selectedImageKey: "aa1dc96aa96f4d67f8ea28948433b8aa", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTTabbarModel in
			let model = HTTabbarModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTTabbarType
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

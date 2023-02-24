//
//  HTDiscoverGameModel.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTDiscoverGameType {
	case `default`
}

class HTDiscoverGameModel: NSObject {

	var title: String?
	var type: HTDiscoverGameType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	class func packModelArray() -> [HTDiscoverGameModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let keyValueArray = [
			[titleKey: "逐日战神", typeKey: HTDiscoverGameType.default, textKey: "https://www.9xiu.com/game/zrzs/mobile", controllerClassKey: UIViewController.self, imageKey: "7331aece3de6ef8a20670a141ee7185a", selectedImageKey: "", selectedKey: false],
			[titleKey: "爱神之箭", typeKey: HTDiscoverGameType.default, textKey: "http://api.9xiu.com/game/common/loginGame?game_id=4012", controllerClassKey: UIViewController.self, imageKey: "d5d1815c6b64861cdc313032ec0bb6da", selectedImageKey: "", selectedKey: false],
			[titleKey: "九秀捕鱼", typeKey: HTDiscoverGameType.default, textKey: "http://api.9xiu.com/game/common/loginGame?game_id=4012", controllerClassKey: UIViewController.self, imageKey: "fd187053b7696065b18e34488a1b9528", selectedImageKey: "", selectedKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverGameModel in
			let model = HTDiscoverGameModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverGameType
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

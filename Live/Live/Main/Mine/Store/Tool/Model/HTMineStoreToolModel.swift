//
//  HTMineStoreToolModel.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStoreToolType {
	case `default`
}

class HTMineStoreToolModel: NSObject {

	var title: String?
	var type: HTMineStoreToolType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var detail: String?
	var buyCoin: String?
	var payMoney: String?
	var titleColor: UIColor?
	var colorList = [CGColor]()

	class func packModelArray() -> [HTMineStoreToolModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"

		let detailKey = "detailKey"
		let buyCoinKey = "buyCoinKey"
		let payMoneyKey = "payMoneyKey"
		let titleColorKey = "titleColorKey"
		let colorListKey = "colorListKey"

		let keyValueArray = [
			[titleKey: "斗图卡", detailKey: "斗图卡特权详解：", typeKey: HTMineStoreToolType.default, textKey: "1.可以使用斗图功能，在直播间用图畅聊\n2.可以收藏聊天区的斗图表情\n3.更多表情更多特权敬请期待", controllerClassKey: UIViewController.self, imageKey: "e5a262ea056a25f33513014e43f03d98", selectedImageKey: "", selectedKey: false, buyCoinKey: "20000九币/月", payMoneyKey: "折合20.0/月", titleColorKey: UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1), colorListKey: [UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor, UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor]],
			[titleKey: "隐身卡", detailKey: "隐身卡特权详解：", typeKey: HTMineStoreToolType.default, textKey: "1.进房不显示进入语和座驾\n2.直播间内不对其他用户显示用户信息\n3.隐身状态所有消费不计入榜单并进入\"神秘人\"模式\n4.购买隐身卡，开启后可以防拉黑", controllerClassKey: UIViewController.self, imageKey: "0fb69d6a3988999e8b0e5ed31955b9d4", selectedImageKey: "", selectedKey: false, buyCoinKey: "100000九币/月", payMoneyKey: "折合100.0/月", titleColorKey: UIColor.init(red: 0.5, green: 0.59, blue: 1, alpha: 1), colorListKey: [UIColor.init(red: 0.447059, green: 0.576471, blue: 1, alpha: 1).cgColor, UIColor.init(red: 0.541176, green: 0.780392, blue: 1, alpha: 1).cgColor]],
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreToolModel in
			let model = HTMineStoreToolModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreToolType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.detail = dictionary[detailKey] as? String
			model.buyCoin = dictionary[buyCoinKey] as? String
			model.payMoney = dictionary[payMoneyKey] as? String
			model.titleColor = dictionary[titleColorKey] as? UIColor
			model.colorList = dictionary[colorListKey] as? [CGColor] ?? [CGColor]()
			return model
		}
		return modelArray
	}
}

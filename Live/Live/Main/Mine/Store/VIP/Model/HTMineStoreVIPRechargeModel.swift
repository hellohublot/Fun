//
//  HTMineStoreVIPRechargeModel.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

enum HTMineStoreVIPRechargeType {
	case `default`
}

class HTMineStoreVIPRechargeModel: NSObject {
	
	var title: String?
	var type: HTMineStoreVIPRechargeType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var buyCoin: String?
	var payMoney: String?
	
	class func packModelArray() -> [HTMineStoreVIPRechargeModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		
		let buyCoinKey = "buyCoinKey"
		let payMoneyKey = "payMoneyKey"
		
		let keyValueArray = [
			[titleKey: "1个月", typeKey: HTMineStoreVIPRechargeType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: true, buyCoinKey: "50000九币", payMoneyKey: "折合¥50.0/月"],
			[titleKey: "3个月", typeKey: HTMineStoreVIPRechargeType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, buyCoinKey: "135000九币", payMoneyKey: "折合¥45.0/月"],
			[titleKey: "6个月", typeKey: HTMineStoreVIPRechargeType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, buyCoinKey: "155000九币", payMoneyKey: "折合¥42.5.0/月"],
			[titleKey: "12个月", typeKey: HTMineStoreVIPRechargeType.default, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, buyCoinKey: "480000九币", payMoneyKey: "折合¥40.0/月"],			
		]
		let modelArray = keyValueArray.map { dictionary -> HTMineStoreVIPRechargeModel in
			let model = HTMineStoreVIPRechargeModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTMineStoreVIPRechargeType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.buyCoin = dictionary[buyCoinKey] as? String
			model.payMoney = dictionary[payMoneyKey] as? String
			return model
		}
		return modelArray
	}
}

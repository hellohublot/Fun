//
//  HTDiscoverSectionModel.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTDiscoverSectionType {
	case banner
	case circle
	case hot
	case new
}

class HTDiscoverSectionModel: NSObject, ReuseSectionArray {
	
	var title: String?
	var type: HTDiscoverSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var showDetailButton: Bool?
	
	var modelArray = [Any]()
	
	class func packModelArray(_ bannerModelArray: Any?, _ hotModelArray: Any?, _ newModelArray: Any?) -> [HTDiscoverSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let showDetailButtonKey = "showDetailButtonKey"
		
		let keyValueArray = [
			[titleKey: "", typeKey: HTDiscoverSectionType.banner, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
			[titleKey: "", typeKey: HTDiscoverSectionType.circle, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
			[titleKey: "热门动态", typeKey: HTDiscoverSectionType.hot, textKey: "", controllerClassKey: UIViewController.self, imageKey: "5f3d5a914b2d008b985c76c3b313f746", selectedImageKey: "", selectedKey: false, showDetailButtonKey: true],
			[titleKey: "新主播", typeKey: HTDiscoverSectionType.new, textKey: "", controllerClassKey: UIViewController.self, imageKey: "4cd331ce155ac7bd6a1f89c178273d0b", selectedImageKey: "", selectedKey: false, showDetailButtonKey: false],
		]
		let modelArray = keyValueArray.map { dictionary -> HTDiscoverSectionModel in
			let model = HTDiscoverSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTDiscoverSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.showDetailButton = dictionary[showDetailButtonKey] as? Bool
			switch model.type {
			case .banner?:
				model.modelArray = bannerModelArray as? [[HTLiveHotBannerModel]] ?? [[HTLiveHotBannerModel]]()
			case .circle?:
				model.modelArray = HTDiscoverCircleModel.packModelArray()
			case .hot?:
				model.modelArray = hotModelArray as? [[HTDiscoverNewsContentModel]] ?? [[HTDiscoverNewsContentModel]]()
			case .new?:
				model.modelArray = newModelArray as? [HTLiveContentModel] ?? [HTLiveContentModel]()
			default:
				break
			}
			return model
		}
		return modelArray
	}
	
	
	class func findModelArrayFromSectionModelArray(_ sectionModelArray: [Any]?, _ type: HTDiscoverSectionType?) -> [Any] {
		guard let sectionModelList = sectionModelArray as? [HTDiscoverSectionModel] else {
			return [Any]()
		}
		for sectionModel in sectionModelList {
			if type == sectionModel.type {
				return sectionModel.modelArray
			}
		}
		return [Any]()
	}
	
}

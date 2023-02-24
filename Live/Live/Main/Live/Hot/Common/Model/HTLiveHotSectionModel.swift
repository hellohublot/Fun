//
//  HTLiveHotSectionModel.swift
//  Live
//
//  Created by hublot on 2018/12/30.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTLiveHotSectionType {
	case scroll
	case recommend
	case banner
	case new
	case hot
}

class HTLiveHotSectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTLiveHotSectionType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?

	var detailTitle: String?
	var detailImage: String?

	var originModelArray = [Any]()
	var modelArray = [Any]()

	class func packModelArray(_ scrollModelArray: Any?, _ recommendModelArray: Any?, _ bannerModelArray: Any?, _ newModelArray: Any?,  _ hotModelArray: Any?) -> [HTLiveHotSectionModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let detailTitleKey = "detailTitleKey"
		let detailImageKey = "detailImageKey"
		let keyValueArray = [
			[titleKey: "", typeKey: HTLiveHotSectionType.scroll, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailTitleKey: "", detailImageKey: ""],
			[titleKey: "推荐", typeKey: HTLiveHotSectionType.recommend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "9e8fd4974a254fbdfd822f1bbba3f2fc", selectedImageKey: "", selectedKey: false, detailTitleKey: "换一批", detailImageKey: "40f6776e0ba9b269a7af6f0acfe94822"],
			[titleKey: "", typeKey: HTLiveHotSectionType.banner, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, detailTitleKey: "", detailImageKey: ""],
			[titleKey: "新人", typeKey: HTLiveHotSectionType.new, textKey: "", controllerClassKey: UIViewController.self, imageKey: "301ca37a04f65c3f6cda00f06095a78c", selectedImageKey: "", selectedKey: false, detailTitleKey: "查看全部", detailImageKey: "3bf3cb5370d39e6f70e8128f705b4462"],
			[titleKey: "热门", typeKey: HTLiveHotSectionType.hot, textKey: "", controllerClassKey: UIViewController.self, imageKey: "8205a7d344413f46de4e2fc69ada794c", selectedImageKey: "", selectedKey: false, detailTitleKey: "查看全部", detailImageKey: "3bf3cb5370d39e6f70e8128f705b4462"],
		]
		let modelArray = keyValueArray.map { dictionary -> HTLiveHotSectionModel in
			let model = HTLiveHotSectionModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTLiveHotSectionType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.detailImage = dictionary[detailImageKey] as? String
			model.detailTitle = dictionary[detailTitleKey] as? String
			switch model.type {
			case .scroll?:
				let modelArray = scrollModelArray as? [[HTLiveContentModel]] ?? [[HTLiveContentModel]]()
				model.modelArray = [randomModelArray(modelArray.first, 6)]
			case .recommend?:
				model.originModelArray = recommendModelArray as? [Any] ?? [Any]()
                model.modelArray = randomRecommendModelArray(model.originModelArray as? [HTLiveContentModel] ?? [HTLiveContentModel]())
			case .banner?:
				model.modelArray = (bannerModelArray as? [[HTLiveHotBannerModel]] ?? [[HTLiveHotBannerModel]]())
			case .new?:
				model.originModelArray = newModelArray as? [Any] ?? [Any]()
				model.modelArray = randomModelArray(newModelArray as? [HTLiveContentModel] ?? [HTLiveContentModel](), 4)
			case .hot?:
				model.modelArray = hotModelArray as? [HTLiveContentModel] ?? [HTLiveContentModel]()
			default:
				break
			}
			return model
		}
		return modelArray
	}

	class func randomModelArray<T>(_ modelArray: [T]?, _ count: Int) -> [T] {
		guard count < (modelArray?.count ?? 0) else {
			return modelArray ?? [T]()
		}
		var originModelArray = modelArray ?? [T]()
		var randomModelArray = [T]()
		for _ in 0..<count {
			let index = Int(arc4random_uniform(UInt32(originModelArray.count)))
			let model = originModelArray[index]
			originModelArray.remove(at: index)
			randomModelArray.append(model)
		}
		return randomModelArray
	}

	class func findModelArrayFromSectionModelArray(_ isOriginModelArray: Bool, _ sectionModelArray: [Any]?, _ type: HTLiveHotSectionType?) -> [Any] {
		guard let sectionModelList = sectionModelArray as? [HTLiveHotSectionModel] else {
			return [Any]()
		}
		for sectionModel in sectionModelList {
			if type == sectionModel.type {
				return isOriginModelArray ? sectionModel.originModelArray : sectionModel.modelArray
			}
		}
		return [Any]()
	}



	class func randomRecommendModelArray(_ recommendModelArray: [HTLiveContentModel]) -> [HTLiveContentModel] {

		var resultModelArray = [HTLiveContentModel]()
		var willRandomSumArray = [HTLiveContentModel]()

		let fliterListBlock: ((_: ((_: HTLiveContentModel) -> Bool)) -> Void) = { fliterBlock in
			for model in recommendModelArray {
				if fliterBlock(model) {
					resultModelArray.append(model)
				} else {
					willRandomSumArray.append(model)
				}
			}
		}
		fliterListBlock({ contentModel in
			return contentModel.is666 == 1
		})
		fliterListBlock({ contentModel in
			return contentModel.is999 == 1
		})
        fliterListBlock({ contentModel in
            return contentModel.isTop == 1
        })

		let randomModelArray = self.randomModelArray(willRandomSumArray, 6 - resultModelArray.count)
		resultModelArray.append(contentsOf: randomModelArray)
		return resultModelArray

	}

	class func replaceRecommendSectionModelArray(_ sectionModelArray: [Any]) {
		guard let sectionModelArray = sectionModelArray as? [HTLiveHotSectionModel] else {
			return
		}
		for sectionModel in sectionModelArray {
			if case .recommend? = sectionModel.type {
				sectionModel.modelArray = randomRecommendModelArray(sectionModel.originModelArray as? [HTLiveContentModel] ?? [HTLiveContentModel]())
			}
		}
	}

}


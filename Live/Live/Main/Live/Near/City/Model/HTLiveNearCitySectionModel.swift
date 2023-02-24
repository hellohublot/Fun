//
//  HTLiveNearSectionModel.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTLiveNearCitySectionType {
	case current
	case `default`
}

class HTLiveNearCitySectionModel: NSObject, ReuseSectionArray {

	var title: String?
	var type: HTLiveNearCitySectionType?
	var modelArray = [Any]()

	class func packModelArray() -> [HTLiveNearCitySectionModel] {


		let cityModelList = HTLiveNearCityModel.packModelArray()
		var keyValueArray = [String: [HTLiveNearCityModel]]()
		for cityModel in cityModelList {
			let firstString = HTLiveNearCityModel.convertCityFirstChar(cityModel.title ?? "")
			if keyValueArray[firstString] == nil {
				keyValueArray[firstString] = [HTLiveNearCityModel]()
			}
			keyValueArray[firstString]?.append(cityModel)
		}

		var modelArray = keyValueArray.map { (key, modelList) -> HTLiveNearCitySectionModel in
			let model = HTLiveNearCitySectionModel.init()
			model.type = .default
			model.title = key
			model.modelArray = modelList.sorted(by: { (this, that) -> Bool in
				return this.title?.compare(that.title ?? "") == .orderedAscending
			})
			return model
		}
		modelArray.sort { (this, that) -> Bool in
			return this.title?.compare(that.title ?? "") == .orderedAscending
		}

		if let currentCityModel = HTLiveNearCityModel.packCurrentCityModel(false) {
			let model = HTLiveNearCitySectionModel.init()
			model.type = .current
			model.title = "当前定位城市"
			model.modelArray = [currentCityModel]
			modelArray.insert(model, at: 0)
		}
		return modelArray
	}
}

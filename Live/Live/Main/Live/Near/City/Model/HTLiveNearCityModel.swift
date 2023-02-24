//
//  HTLiveNearCityModel.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveNearCityModel: NSObject {

	var id: String?
	var title: String?

	class func packModelArray() -> [HTLiveNearCityModel] {
		let idKey = "idKey"
		let titleKey = "titleKey"
		let keyValueArray = [
			[idKey: "1", titleKey: "北京"],
			[idKey: "2", titleKey: "天津"],
			[idKey: "3", titleKey: "河北"],
			[idKey: "4", titleKey: "山西"],
			[idKey: "5", titleKey: "内蒙古"],
			[idKey: "6", titleKey: "辽宁"],
			[idKey: "7", titleKey: "吉林"],
			[idKey: "8", titleKey: "黑龙江"],
			[idKey: "9", titleKey: "上海"],
			[idKey: "10", titleKey: "江苏"],
			[idKey: "11", titleKey: "浙江"],
			[idKey: "12", titleKey: "安徽"],
			[idKey: "13", titleKey: "福建"],
			[idKey: "14", titleKey: "江西"],
			[idKey: "15", titleKey: "山东"],
			[idKey: "16", titleKey: "河南"],
			[idKey: "17", titleKey: "湖北"],
			[idKey: "18", titleKey: "湖南"],
			[idKey: "19", titleKey: "广东"],
			[idKey: "20", titleKey: "广西"],
			[idKey: "21", titleKey: "海南"],
			[idKey: "22", titleKey: "重庆"],
			[idKey: "23", titleKey: "四川"],
			[idKey: "24", titleKey: "贵州"],
			[idKey: "25", titleKey: "云南"],
			[idKey: "26", titleKey: "西藏"],
			[idKey: "27", titleKey: "陕西"],
			[idKey: "28", titleKey: "甘肃"],
			[idKey: "29", titleKey: "青海"],
			[idKey: "30", titleKey: "宁夏"],
			[idKey: "31", titleKey: "新疆"],
			[idKey: "32", titleKey: "香港"],
			[idKey: "33", titleKey: "澳门"],
			[idKey: "34", titleKey: "台湾"],
		]
		let modelArray = keyValueArray.map { dictionary -> HTLiveNearCityModel in
			let model = HTLiveNearCityModel()
			model.id = dictionary[idKey]
			model.title = dictionary[titleKey]
			return model
		}
		return modelArray
	}

	class var userSelectedCityName: String {
		get {
			return UserDefaults.standard.value(forKey: #function) as? String ?? ""
		}
		set {
			UserDefaults.standard.setValue(newValue, forKey: #function)
		}
	}

	class func packCurrentCityModel(_ userSelected: Bool) -> HTLiveNearCityModel? {
		var provinceName = HTLiveNearLocationManager.locationProvinceName
		if userSelected, userSelectedCityName.count > 0 {
			provinceName = userSelectedCityName
		}
		var currentCityModel: HTLiveNearCityModel?
		let cityModelList = HTLiveNearCityModel.packModelArray()
		for cityModel in cityModelList {
			if cityModel.title?.contains(provinceName) == true || provinceName.contains(cityModel.title ?? "") {
				currentCityModel = HTLiveNearCityModel()
				currentCityModel?.id = cityModel.id
				currentCityModel?.title = cityModel.title
			}
		}
		return currentCityModel
	}

	class func convertCityFirstChar(_ cityString: String) -> String {
		let cityMutableString = NSMutableString.init(string: cityString)
		var rangePoint = CFRange.init(location: 0, length: cityMutableString.length)
		CFStringTransform(cityMutableString, &rangePoint, kCFStringTransformMandarinLatin, false)
		CFStringTransform(cityMutableString, &rangePoint, kCFStringTransformStripDiacritics, false)
		let cityName = cityMutableString.capitalized
		if let firstChar = cityName.first {
			return String.init(firstChar)
		}
		return ""
	}

}

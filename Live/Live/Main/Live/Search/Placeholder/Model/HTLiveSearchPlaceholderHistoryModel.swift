//
//  HTLiveSearchPlaceholderHistoryModel.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveSearchPlaceholderHistoryModel: NSObject {
	
	var title: String?
	
	
	
	static let searchHistoryKey = "com.hublot.searchHistoryKey"
	
	class func packModelArray() -> [HTLiveSearchPlaceholderHistoryModel] {
		let keyValueList = UserDefaults.standard.value(forKey: searchHistoryKey) as? [String] ?? [String]()
		let modelArray = keyValueList.map { (title) -> HTLiveSearchPlaceholderHistoryModel in
			let model = HTLiveSearchPlaceholderHistoryModel()
			model.title = title
			return model
		}
		return modelArray
	}
	
	class func appendHistory(_ title: String) {
		var keyValueArray = [title]
		let keyValueList = UserDefaults.standard.value(forKey: searchHistoryKey) as? [String] ?? [String]()
		for historyTitle in keyValueList {
			if keyValueArray.contains(historyTitle) == false {
				keyValueArray.append(historyTitle)
			}
		}
		UserDefaults.standard.setValue(keyValueArray, forKey: searchHistoryKey)
	}
	
	class func clearHistory() {
		UserDefaults.standard.setValue(nil, forKey: searchHistoryKey)
	}
	
}

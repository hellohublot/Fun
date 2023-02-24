//
//  HTDiscoverNewsContentSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum HTDiscoverNewsContentSectionType: String {
	case normal = "1"
	case glad = "4"
	case detailReply = ""
}

class HTDiscoverNewsContentSectionModel: NSObject, ReuseSectionArray {
	
	var type: HTDiscoverNewsContentSectionType?
	
	var model: HTDiscoverNewsContentModel

	var showIndexReply = true
	
	init(_ model: HTDiscoverNewsContentModel) {
		self.model = model
	}
	
	var modelArray = [Any]()
		
	class func packModelArray(_ value: [Any]) -> [HTDiscoverNewsContentSectionModel] {
		let contentModelArray = HTDiscoverNewsContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTDiscoverNewsContentModel] ?? [HTDiscoverNewsContentModel]()
		let sectionModelArray = contentModelArray.map { (contentModel) -> HTDiscoverNewsContentSectionModel in
			let sectionModel = HTDiscoverNewsContentSectionModel.init(contentModel)
			sectionModel.type = HTDiscoverNewsContentSectionType.init(rawValue: contentModel.type) ?? .normal
			sectionModel.modelArray = [contentModel]
			return sectionModel
		}
		return sectionModelArray
	}
	
}

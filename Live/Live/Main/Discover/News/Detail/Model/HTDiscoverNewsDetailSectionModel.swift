//
//  HTDiscoverNewsDetailSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverNewsDetailSectionModel: HTDiscoverNewsContentSectionModel {

	class func packModelArray(_ contentModel: HTDiscoverNewsContentModel?, _ replyModelArray: [Any]?) -> [HTDiscoverNewsDetailSectionModel] {
		guard let contentModel = contentModel else {
			return []
		}
		let contentSectionModel = HTDiscoverNewsDetailSectionModel.init(contentModel)
		contentSectionModel.type = HTDiscoverNewsContentSectionType.init(rawValue: contentModel.type) ?? .normal
		contentSectionModel.modelArray = [contentModel]
		contentSectionModel.showIndexReply = false


		let replySectionModel = HTDiscoverNewsDetailSectionModel.init(contentModel)
		replySectionModel.type = .detailReply
		replySectionModel.modelArray = replyModelArray ?? []

		return [contentSectionModel, replySectionModel]
	}

	class func findModelArrayWithSectionType(_ type: HTDiscoverNewsContentSectionType?, _ sectionModelArray: [Any]) -> [Any] {
		guard let sectionModelArray = sectionModelArray as? [HTDiscoverNewsDetailSectionModel] else {
			return []
		}
		for sectionModel in sectionModelArray {
			if sectionModel.type == type {
				return sectionModel.modelArray
			}
		}
		return []
	}

}

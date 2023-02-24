//
//  HTDiscoverHomeDetailMemberSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailMemberSectionModel: NSObject, ReuseSectionArray {

	var title: String?

	var modelArray = [Any]()

	class func packModelArray(_ modelArray: [HTDiscoverHomeDetailMemberModel], _ homeLevelList: [String]) -> [HTDiscoverHomeDetailMemberSectionModel] {
		var sectionModelArray = homeLevelList.map { (levelTitle) -> HTDiscoverHomeDetailMemberSectionModel in
			let sectionModel = HTDiscoverHomeDetailMemberSectionModel.init()
			sectionModel.title = levelTitle
			return sectionModel
		}
		for model in modelArray {
			let modelLevelIndex = (Int(model.mtype) ?? 0) - 1
			if sectionModelArray.count > modelLevelIndex {
				let sectionModel = sectionModelArray[modelLevelIndex]
				sectionModel.modelArray.append(model)
			}
		}
		sectionModelArray = sectionModelArray.filter { (sectionModel) -> Bool in
			return sectionModel.modelArray.count > 0
		}
		sectionModelArray = sectionModelArray.reversed()
		return sectionModelArray
	}

	class func findAllMemberModelArray(_ sectionModelArray: [Any]?) -> [HTDiscoverHomeDetailMemberModel] {
		guard let sectionModelArray = sectionModelArray as? [HTDiscoverHomeDetailMemberSectionModel] else {
			return []
		}
		var modelArray = [HTDiscoverHomeDetailMemberModel]()
		for sectionModel in sectionModelArray {
			modelArray += (sectionModel.modelArray as? [HTDiscoverHomeDetailMemberModel] ?? [HTDiscoverHomeDetailMemberModel]())
		}
		return modelArray
	}

}

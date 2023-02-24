//
//  HTDiscoverHomeDetailModel.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverHomeDetailModel: NSObject {

	@objc var isApply = 0
	@objc var leaderInfo: HTDiscoverHomeDetailLeaderModel?
	@objc var familyInfo: HTDiscoverHomeModel?
	@objc var anchorList = [String]()
	@objc var memberList = [String]()
    @objc var userFamilyinfo = [String: Any]()

	override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
		return [
			"leaderInfo": HTDiscoverHomeDetailLeaderModel.self,
			"familyInfo": HTDiscoverHomeModel.self
		]
	}

}

class HTDiscoverHomeDetailLeaderModel: NSObject {

	@objc var headimage = ""
	@objc var nickname = ""
	@objc var wealth = ""

}

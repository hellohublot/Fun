//
//  HTMineToolModel.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineToolModel: NSObject {
	
	@objc var id = ""
	@objc var uid = ""
	@objc var gid = ""
	@objc var rid = ""
	@objc var starttime = ""
	@objc var endtime = ""
	@objc var num = ""
	@objc var isactive = ""
	@objc var stocktype = ""
	@objc var status = 0
	@objc var deadLine = 0
	@objc var giftname = ""
	@objc var name = ""
	@objc var price = ""
	@objc var typeTag = 0
	@objc var imgurl = ""
	@objc var category = 0
	
	static func packModelArray(_ type: HTMineToolPageType?, _ value: [String: Any]) -> [HTMineToolModel] {
		var keyValueArray = [Any]()
		switch type {
		case .seat?:
			if let seatList = value["carlist"] as? [Any] {
				keyValueArray.append(contentsOf: seatList)
			}
		case .vip?:
			if let vipList = value["viplist"] as? [Any] {
				keyValueArray.append(contentsOf: vipList)
			}
		case .gift?:
			if let giftList = value["giftlist"] as? [Any] {
				keyValueArray.append(contentsOf: giftList)
			}
		case .all?:
			for (_, item) in value {
				if let itemList = item as? [Any] {
					keyValueArray.append(contentsOf: itemList)
				}
			}
		default:
			break
		}
		let modelArray = HTMineToolModel.mj_objectArray(withKeyValuesArray: keyValueArray) as? [HTMineToolModel] ?? [HTMineToolModel]()
		return modelArray
	}

}

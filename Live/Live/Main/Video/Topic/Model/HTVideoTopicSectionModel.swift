//
//  HTVideoTopicSectionModel.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoTopicSectionModel: NSObject, ReuseSectionArray {
	
	@objc var topicid = 0
	@objc var actitle = ""
	@objc var total = 0
	@objc var list = [HTVideoContentModel]()
	
	var modelArray: [Any] {
		return [list]
	}
	
	override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
		return ["list": HTVideoContentModel.self]
	}

}

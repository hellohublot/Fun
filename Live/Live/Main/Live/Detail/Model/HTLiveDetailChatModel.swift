//
//  HTLiveDetailChatModel.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveDetailChatModel: NSObject {

	@objc var msghead: HTLiveDetailChatHeadModel?

	@objc var msgbody: HTLiveDetailChatBodyModel?

	override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
		return [
			"msghead": HTLiveDetailChatHeadModel.self,
			"msgbody": HTLiveDetailChatBodyModel.self
		]
	}

}

class HTLiveDetailChatHeadModel: NSObject {

	@objc var uid = 0

	@objc var rid = 0

	@objc var transmode = 0

	@objc var msgid = 0

}

class HTLiveDetailChatBodyModel: NSObject {

	@objc var srcnickname = ""

	@objc var content = ""

	@objc var os = 0

	@objc var token = ""

}

//
//  HTMineUserInfoModel.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineUserInfoModel: NSObject {
	@objc var uid = ""
	@objc var accountname = ""
	@objc var headimage = ""
	@objc var headimage120 = ""
	@objc var nickname = ""
	@objc var address = ""
	@objc var money = ""
	@objc var tokencoin = ""
	@objc var wealthlevel = 0
	@objc var wealth = ""
	@objc var percent = 0
	@objc var nextlevelvalues = 0
	@objc var accountid = ""
	@objc var phone = ""
	@objc var isBind = false
	@objc var is_anchor = 0
	@objc var rid = 0
	@objc var isCert = 0
	@objc var stealthDueTime = ""
	@objc var stealthState = 0
	@objc var pictureDueTime = ""
	@objc var pictureState = 0
	@objc var province = ""
	@objc var city = ""
	@objc var sex = ""
	@objc var credit = ""
	@objc var creditlevel = 0
	@objc var creditpercent = 0
	@objc var nextlevelcredits = 0
	@objc var fansNum = 0
	@objc var followNum	= 0
	@objc var car = [Any]()
	@objc var isCharge = 0
	@objc var isOneBag = 0
	@objc var vipId = 0
	@objc var dt_ticket = ""
	@objc var taskStatus = 0
	
	
	@objc var isfollow = 0
	@objc var fanscount = 0
	@objc var guardcount = 0
	@objc var phonehallposter = ""
	@objc var creditLevel = 0
	@objc var isplay = ""
	@objc var roomType = ""
	@objc var is_black = 0
	@objc var is_love = 0
	@objc var familyBadge = ""
	@objc var memberType = ""
	@objc var fid = ""
	@objc var is_friend = 0
	@objc var remark_name = ""	
	@objc var follow_num = 0
	
	@objc var badgeInfo = [String: Any]()
	@objc var badgeList = [String]()
	
	override func mj_keyValuesDidFinishConvertingToObject() {
		badgeList = badgeInfo["taskBadge"] as? [String] ?? [String]()
	}
}

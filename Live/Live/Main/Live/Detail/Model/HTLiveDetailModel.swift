//
//  HTLiveDetailModel.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveDetailModel: NSObject {
	
	@objc var uid = 0
	@objc var usercount = 0
	@objc var fans_count = 0
	@objc var artistuid = 0
	@objc var creditlevel = 0
	@objc var nickname = ""
	@objc var headimage = ""
	@objc var rid = 0
	@objc var status = 0
	@objc var publicnotice = ""
	@objc var roomType = 0
	@objc var signed = 0
	@objc var hotprice = ""
	@objc var opentime = ""
	@objc var isfollow = false
	@objc var isBlack = 0
	@objc var isbanspeek = false
	@objc var managerlevel = 0
	@objc var roomtoken = ""
	@objc var g_ip = ""
	@objc var g_port = ""
	@objc var game12ip = ""	
	@objc var game12port = ""	
	@objc var videoline = ""
	@objc var video_line = ""
	@objc var video_domain = ""
	@objc var video_flow = ""
	@objc var video_port = ""	
	@objc var sendType = ""
	@objc var share = [String: Any]()	
	@objc var activity_version = 0
	@objc var bhouse = [String: Any]()	
	@objc var blackHouse = 0
	@objc var hellocontent = ""
	@objc var inrid = 0
	@objc var inVoiceLive = 0
	@objc var voiceMicInfo = [String: Any]()	
	@objc var voiceStar = 0
	@objc var voiceKey = ""	
	@objc var voicePoints = 0
	@objc var thestarnum = 0
	@objc var box_start = 0
	@objc var box_prize = [Any]()	
}

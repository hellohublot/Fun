//
//  HTLiveContentModel.swift
//  Live
//
//  Created by hublot on 2018/12/26.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTLiveContentModel: NSObject {
	@objc var rid = ""
	@objc var uid = ""
	@objc var nickname = ""
	@objc var liveimage = ""
	@objc var phonehallposter = ""
	@objc var recommend = ""
	@objc var province = ""
	@objc var status = ""
	@objc var sort = ""
	@objc var roomType = ""
	@objc var usercount = 0
	@objc var fanscount = 0
	@objc var opentime = ""
	@objc var timeLength = 0
	@objc var credit = ""
	@objc var creditLevel = 0
	@objc var hotValue = ""
	@objc var tags = [String: Any]()
	@objc var city = ""
	@objc var publicnotice = ""
	@objc var isTag5 = 0
	@objc var video_domain = ""
	@objc var video_flow = ""
	@objc var video_line = ""
	@objc var videoline = ""

    
	@objc var isTop = 0
	@objc var is_love = 0
	@objc var isfollow = 0
	@objc var tag = 0
	@objc var label = 0
	@objc var pktype = ""
    
    @objc var is666 = 0
    @objc var is999 = 0


    @objc var flagImageString = ""
	@objc var flagTitleString = ""
	@objc var flagGradientColorList = [CGColor]()
	@objc var pkContentString = ""
	@objc var showCityTitle = false



	override func mj_keyValuesDidFinishConvertingToObject() {
		if isTop  == 1 {
			flagTitleString = "置顶"
			flagGradientColorList = [
				UIColor.init(red: 1, green: 0.870588, blue: 0.592157, alpha: 1).cgColor,
				UIColor.init(red: 0.843137, green: 0.662745, blue: 0.317647, alpha: 1).cgColor
			]
		} else if is_love == 1 {
			flagTitleString = "真爱"
			flagGradientColorList = [
				UIColor.init(red: 1, green: 0.815686, blue: 0.462745, alpha: 1).cgColor,
				UIColor.init(red: 1, green: 0.482353, blue: 0.568627, alpha: 1).cgColor
			]
		} else if tag == 5 {
			flagTitleString = "天籁"
			flagGradientColorList = [
				UIColor.init(red: 0.894118, green: 0.462745, blue: 1, alpha: 1).cgColor,
				UIColor.init(red: 0.690196, green: 0.482353, blue: 1, alpha: 1).cgColor
			]
		} else if tag == 6 {
			flagTitleString = "炫舞"
			flagGradientColorList = [
				UIColor.init(red: 1, green: 0.866667, blue: 0.462745, alpha: 1).cgColor,
				UIColor.init(red: 1, green: 0.580392, blue: 0.482353, alpha: 1).cgColor
			]
		} else if label == 1 {
			flagTitleString = "周星"
			flagGradientColorList = [
				UIColor.init(red: 0.392157, green: 0.941176, blue: 1, alpha: 1).cgColor,
				UIColor.init(red: 0.478431, green: 0.592157, blue: 1, alpha: 1).cgColor
			]
		} else if label == 2 {
			flagTitleString = "魅力"
			flagGradientColorList = [
				UIColor.init(red: 0.392157, green: 0.941176, blue: 1, alpha: 1).cgColor,
				UIColor.init(red: 0.478431, green: 0.592157, blue: 1, alpha: 1).cgColor
			]
		}
        if is666 == 1 {
            flagImageString = "757ab145c4ca2564a9cfab31f96fc2a5"
        } else if is999 == 1 {
            flagImageString = "1c154794a6af405644723d48aabb2083"
        }
		switch pktype {
		case "6":
			pkContentString = "PK排位中"
		case "9", "10":
			pkContentString = "游戏PK"
		default:
			if pktype.count > 0 {
				pkContentString = "正在PK"
			}
		}
	}
	
}

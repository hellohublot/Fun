//
//  Request.swift
//  Shop
//
//  Created by hublot on 2018/3/31.
//  Copyright © 2018年 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftNetwork
import Alamofire

class Request: NSObject {
	
	/*-------------------------------------/ 域名 /-----------------------------------*/
	
	static func server() -> String {
		if let domainServer = domainServer, domainServer.count > 0 {
			return domainServer
		}
		return domainServerList.first ?? ""
	}

	static let domainServerList = [
		"api.9xiu.com",
	]
	
	static var domainServer: String? {
		get {
			let domain = UserDefaults.standard.value(forKey: #function) as? String
			return domain
		}
		set {
			UserDefaults.standard.setValue(newValue, forKey: #function)
		}
	}

	static func api(_ name: String) -> String {
		return "https://" + server() + "/" + name
	}

	func api(_ name: String) -> String {
		return type(of: self).api(name)
	}
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	var session: Session?
	
	public init(_ cache: Bool? = false, _ reumeTitle: String? = "", _ errorTitle: String? = "") {
		let session = Session.default
		if cache == true {
			session.cacher = Cacher()
		}
		session.parser = JSONParse()
		session.connector = Task()
		if let reumeTitle = reumeTitle, let errorTitle = errorTitle {
			let stater = Stater()
			stater.resumeTitle = reumeTitle
			stater.errorTitle = errorTitle
			session.stater = stater
		}
		self.session = session
	}
	
	static var list: Request {
		return Request.init(true, nil, nil)
	}
	
	static var action: Request {
		return Request.init(false, "", "")
	}
	
	static var lost: Request {
		return Request.init(false, nil, nil)
	}
	
	static var reload: Request {
		return Request.init(true, "", "")
	}
	
	
	
	func request(_ string: String, _ method: Alamofire.HTTPMethod = .post, parameter: [String: Any] = [String: Any](), _ result: @escaping ResultHandler) {

		var urlparameter = [String: Any]()
		
		urlparameter["XDEBUG_SESSION_START"] = "9527"

		let tokenKey = "token"
		urlparameter[tokenKey] = HTUserAuthManager.userToken


		let osKey = "os"
		urlparameter[osKey] = "2"
		let deviceKey = "imei"
		urlparameter[deviceKey] = "6934bf3cb581a9af96bfe51b48238e7b"
		let timeKey = "reqtime"
		urlparameter[timeKey] = Int(Date().timeIntervalSince1970) * 1000
		var encrypt = "lsdfnrtpmsldyncs\(urlparameter[tokenKey] ?? "")\(urlparameter[deviceKey] ?? "")\(urlparameter[osKey] ?? "")\(urlparameter[timeKey] ?? "")"
		encrypt = Encrypt.md5(encrypt)
		encrypt = String(encrypt[encrypt.startIndex..<encrypt.index(encrypt.startIndex, offsetBy: 10)]) + String(encrypt[encrypt.index(encrypt.endIndex, offsetBy: -10)..<encrypt.endIndex])
		encrypt = Encrypt.md5(encrypt)
		urlparameter["ncode"] = encrypt

		var urlstring = string
		var components = URLComponents.init(string: urlstring)
		var urlQuery = components?.queryItems ?? [URLQueryItem]()
		for (key, value) in urlparameter {
			let item = URLQueryItem.init(name: key, value: "\(value)")
			urlQuery.append(item)
		}
		components?.queryItems = urlQuery
		urlstring = components?.string ?? urlstring
		urlstring = urlstring.removingPercentEncoding ?? ""
		urlparameter.removeAll()

		let reresult: ResultHandler = { response in

//			4101 token

			if response.data == nil, response.data == nil {
				if case JSONError.willlogin = response.error {
					let lastToken = HTUserAuthManager.userToken
					HTUserAuthManager.userToken = ""
					if lastToken.count > 0 {
						NotificationCenter.default.post(name: HTUserAuthManager.authStateNotification, object: nil)
					}
				}
			}

			result(response)
		}
		session?.request(urlstring, method, parameter: parameter, header: [:], reresult)
	}
	
	
	
	
	/*-------------------------------------/ 便利 /-----------------------------------*/
	
	
	static let placeImage = UIImage.init(named: "47cefe522a86ae9b3103a3c67f009c35")
	
	static func url(_ string: String?) -> URL {
		let url = string ?? ""
		return URL.init(string: url) ?? URL.init(fileURLWithPath: url)
	}

	
	
	
	
	/*-------------------------------------/ 接口 /-----------------------------------*/
	
	func liveList(_ categoryId: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("channel/main/channelTag"), .get, parameter: [
			"tag": categoryId,
			"page": pageIndex
		], result)
	}

	func historyList(_ result: @escaping ResultHandler) {
		request(api("channel/mobileuser/getHistoryList"), .get, parameter: [
			:
		], result)
	}
	
	func liveDetail(_ roomIdString: String, _ result: @escaping ResultHandler) {
		request(api("v2/room_live/enterRoom"), .get, parameter: [
			"rid": roomIdString
		], result)
	}

	func mainList(_ result: @escaping ResultHandler) {
		request(api("v2/main"), .get, parameter: [
			:
		], result)
	}

	func mainBanner(_ result: @escaping ResultHandler) {
		request(api("channel/main/ad"), .get, parameter: [
			:
		], result)
	}

	func mainHot(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("v2/main/getHotRoom"), .get, parameter: [
			"page": pageIndex
		], result)
	}

	func followList(_ result: @escaping ResultHandler) {
		request(api("channel/main/openFollow"), .get, parameter: [
			:
		], result)
	}

	func nearList(_ cityIdString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("channel/main/city"), .get, parameter: [
			"id": cityIdString,
			"page": pageIndex
		], result)
	}
	
	func bannerList(_ result: @escaping ResultHandler) {
		request(api("channel/main/ad"), .get, parameter: [
			:
		], result)
	}
	
	func hotList(_ result: @escaping ResultHandler) {
		request(api("dynamic/dynamic/getFindList"), .get, parameter: [
			:
		], result)
	}

	func hotRoomList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("v2/main/getHotRoom"), .get, parameter: [
			"page": pageIndex
		], result)
	}
		
	func recommendVideoList(_ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/recommendList"), .get, parameter: [
			:
		], result)
	}
	
	func followVideoList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/videoFollow"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func topicVideoList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/actList"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func videoDetail(_ videoIdString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/playVideo"), .get, parameter: [
			"videoid": videoIdString
		], result)
	}
	
	func blackList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("user/getUserBlackList"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func userMessageToken(_ lastMessageToken: String, _ result: @escaping ResultHandler) {
		request(api("im/gettoken"), .get, parameter: [
			"token": lastMessageToken
		], result)
	}
	
	func shopPolicyList(_ result: @escaping ResultHandler) {
		request(api("shop/getGuardList"), .get, parameter: [
			:
		], result)
	}
	
	func shopCarList(_ result: @escaping ResultHandler) {
		request(api("shop/getCarList"), .get, parameter: [
			:
		], result)
	}

	func shopNumberList(_ result: @escaping ResultHandler) {
		request(api("shop/accountList"), .get, parameter: [
			:
		], result)
	}

	func mineBadgeList(_ result: @escaping ResultHandler) {
		request(api("ucenter/my/myBadge"), .get, parameter: [
			:
		], result)
	}

	func userInfo(_ result: @escaping ResultHandler) {
		request(api("user/getuserinfo"), .get, parameter: [
			:
		], result)
	}

	func userLogin(_ accountString: String, _ passwordString: String, _ result: @escaping ResultHandler) {
		request(api("oAuth/regLogin/login"), .post, parameter: [
			"accountname": accountString,
			"password": passwordString
		], result)
	}

	func platformLogin(_ platformType: SSDKPlatformType?, _ value: [String: Any], _ result: @escaping ResultHandler) {
		var reloadValue = value
		var sourceString = ""
		switch platformType {
		case .typeQQ?:
			sourceString = "qq"
		case .typeWechat?:
			sourceString = "wechat"
		case .typeSinaWeibo?:
			sourceString = "weibo"
		default:
			break
		}
		reloadValue["source"] = sourceString
		reloadValue["accesstoken"] = reloadValue["access_token"]
		request(api("oAuth/thirdLogin"), .post, parameter: reloadValue, result)
	}

	func activityList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("activity/activity_list/index"), .get, parameter: [
			"pagenum": pageIndex
		], result)
	}

	func homeList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("family/family/getFamilyList"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func rankList(_ type: HTDiscoverRankPageType?, _ result: @escaping ResultHandler) {
		var url = ""
		switch type {
		case .star?:
			url = "rank/getartistrank"
		case .rich?:
			url = "rank/getrichrank"
		case .pk?:
			url = "rank/getPkRank"
		case .charm?:
			url = "rank/getCharmRank"
		default:
			break
		}
		request(api(url), .get, parameter: [
			:
		], result)
	}
	
	
	func searchRecommendList(_ result: @escaping ResultHandler) {
		request(api("channel/search/getRecommendRoom"), .get, parameter: [
			:
		], result)
	}
	
	func searchList(_ searchKey: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("channel/search"), .get, parameter: [
			"key": searchKey,
			"page": pageIndex
		], result)
	}

	func homeRankList(_ typeString: String, _ result: @escaping ResultHandler) {
		request(api("family/family/getFamilyRank"), .get, parameter: [
			"type": typeString,
		], result)
	}
	
	func mineServiceList(_ result: @escaping ResultHandler) {
		request(api("common/getRecruitQQ"), .get, parameter: [
			:
		], result)
	}
	
	func userDetail(_ uidString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/artist/getArtistInfo"), .get, parameter: [
			"uid": uidString
		], result)
	}
	
	func userDetailNewsList(_ uidString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/dynamic/getArtistDynamicList"), .get, parameter: [
			"uid": uidString,
			"page": pageIndex
		], result)
	}
	
	func userDetailPhotoList(_ uidString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/photo/getPhotoList_v2"), .get, parameter: [
			"uid": uidString,
			"page": pageIndex,
			"type": 0
			], result)
	}
	
	func userDetailVideoList(_ uidString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/userIndex"), .get, parameter: [
			"uid": uidString,
			"page": pageIndex
		], result)
	}
	
	func userDetailInfoList(_ uidString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/archives/getArchives"), .get, parameter: [
			"uid": uidString,
		], result)
	}
	
	func discoverNewsContentList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/dynamic/getHallList"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func discoverNewsFollowList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/dynamic/getFollowDynamicList"), .get, parameter: [
			"page": pageIndex,
		], result)
	}

	func discoverNewsLike(_ newsIdString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/praise/addPraise"), .get, parameter: [
			"subid": newsIdString,
			"type": 0
		], result)
	}

	func discoverNewsContentDetailReplyList(_ contentIdString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/comment/getDynamicCommentList"), .get, parameter: [
			"id": contentIdString,
			"page": pageIndex
		], result)
	}

	func homeSearch(_ keyString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("familySearch"), .get, parameter: [
			"search_txt": keyString,
			"per_page": pageIndex
		], result)
	}

	func homeDetail(_ homeIdString: String, _ result: @escaping ResultHandler) {
		request(api("family/family/getFamilyInfo"), .get, parameter: [
			"fid": homeIdString,
		], result)
	}

	func homeRadioList(_ homeIdString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("family/family/getFamilyAnchors"), .get, parameter: [
			"fid": homeIdString,
			"page": pageIndex
		], result)
	}

	func homeMemberList(_ homeIdString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("family/family/getFamilyMember"), .get, parameter: [
			"fid": homeIdString,
			"page": pageIndex
		], result)
	}
	
	func userToolList(_ result: @escaping ResultHandler) {
		request(api("user/myStock"), .get, parameter: [
			:
		], result)
	}
	
	func userLoveList(_ result: @escaping ResultHandler) {
		request(api("api/truelove/myTrueLoveList"), .get, parameter: [
			:
		], result)
	}
	
	func userManagerList(_ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("ucenter/usermanager/getManagerRoom"), .get, parameter: [
			"page": pageIndex
		], result)
	}
	
	func userGuardList(_ result: @escaping ResultHandler) {
		request(api("ucenter/my/getGuard"), .get, parameter: [
			:
		], result)
	}
	
	func userFansList(_ uidString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/getFansList"), .get, parameter: [
			"uid": uidString,
			"page": pageIndex,
		], result)
	}
	
	func userFollowList(_ followTypeString: String, _ uidString: String, _ pageIndex: Int, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/followList"), .get, parameter: [
			"uid": uidString,
			"page": pageIndex,
			"type": followTypeString
		], result)
	}

	func userFollow(_ uidString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/followUser"), .get, parameter: [
			"followuid": uidString,
		], result)
	}

	func userFollowCancel(_ uidString: String, _ result: @escaping ResultHandler) {
		request(api("dynamic/videoshort/cancleFollowUser"), .get, parameter: [
			"followuid": uidString,
		], result)
	}

	func userHidden(_ hidden: Bool, _ result: @escaping ResultHandler) {
		request(api("user/userstatus"), .get, parameter: [
			"switchs": hidden ? 1 : 0
		], result)
	}
    
    func registerPhoneCode(_ phoneString: String, _ result: @escaping ResultHandler) {
        request(api("message/msgRegistSend"), .get, parameter: [
            "mobile": phoneString
        ], result)
    }
    
    func forgetPhoneCode(_ phoneString: String, _ result: @escaping ResultHandler) {
        request(api("message/msgFindPwdSend"), .post, parameter: [
            "mobile": phoneString
        ], result)
    }
    
    func cancelPhoneCode(_ phoneString: String, _ result: @escaping ResultHandler) {
        request(api("message/msgUnBindingSend"), .post, parameter: [
            "mobile": phoneString
        ], result)
    }
    
    func bindPhoneCode(_ phoneString: String, _ result: @escaping ResultHandler) {
        request(api("message/msgBindingSend"), .get, parameter: [
            "mobile": phoneString
        ], result)
    }
    
    func registerAccount(_ phoneString: String, _ codeString: String, _ passwordString: String, _ result: @escaping ResultHandler) {
        request(api("oAuth/regLogin/register"), .post, parameter: [
            "channel": "69xiuiphone",
            "accountname": phoneString,
            "icode": codeString,
            "password": passwordString
        ], result)
    }
    
    func forgetPassword(_ phoneString: String, _ codeString: String, _ passwordString: String, _ result: @escaping ResultHandler) {
        request(api("message/resetPWD"), .post, parameter: [
            "mobile": phoneString,
            "code": codeString,
            "pwd": passwordString,
            "pwd2": passwordString
        ], result)
    }
    
    func modifyPassword(_ lastPassword: String, _ thisPassword: String, _ result: @escaping ResultHandler) {
        request(api("user/changepassword"), .get, parameter: [
            "oldpassword": lastPassword,
            "password": thisPassword,
        ], result)
    }
    
    func cancelPhone(_ phoneString: String, _ codeString: String, _ result: @escaping ResultHandler) {
        let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
        request(api("message/unBinding"), .post, parameter: [
            "mobile": phoneString,
            "code": codeString,
            "uid": userInfoModel?.uid ?? ""
        ], result)
    }
    
    func bindPhone(_ phoneString: String, _ codeString: String, _ result: @escaping ResultHandler) {
        let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
        request(api("user/bindingMobile"), .get, parameter: [
            "mobile": phoneString,
            "code": codeString,
            "uid": userInfoModel?.uid ?? ""
        ], result)
    }
    
    func blackUserDelete(_ uidString: String, _ result: @escaping ResultHandler) {
        request(api("im/delBlackStaus"), .post, parameter: [
            "dstuid": uidString,
        ], result)
    }
    
    func userConfigList(_ result: @escaping ResultHandler) {
        request(api("im/getUserConfig"), .post, parameter: [
            :
        ], result)
    }
    
    func modifyUserFriend(_ friendString: String, _ result: @escaping ResultHandler) {
        request(api("im/setFriendRequestConfig"), .post, parameter: [
            "type": friendString
        ], result)
    }
    
    func homeDetailGlory(_ homeIdString: String, _ result: @escaping ResultHandler) {
        request(api("family/family/familyHonor"), .get, parameter: [
            "fid": homeIdString
        ], result)
    }
    
    func homeDetailRich(_ homeIdString: String, _ result: @escaping ResultHandler) {
        request(api("family/family/richRankInfo"), .get, parameter: [
            "fid": homeIdString
        ], result)
    }
    
    func homeSendJoin(_ homeIdString: String, _ result: @escaping ResultHandler) {
        request(api("family/family/appyfamily"), .get, parameter: [
            "fid": homeIdString
        ], result)
    }
    
    func homeSendExit(_ homeIdString: String, _ result: @escaping ResultHandler) {
        request(api("family/family/leavefamily"), .get, parameter: [
            "fid": homeIdString
        ], result)
    }
    
    func rankFollowUser(_ uidString: String, _ result: @escaping ResultHandler) {
        request(api("user/subscribeFollow"), .get, parameter: [
            "followuid": uidString,
            "identify": "1"
        ], result)
    }

}

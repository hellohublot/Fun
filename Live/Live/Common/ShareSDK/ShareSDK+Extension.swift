//
//  ShareSDK+Extension.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import Foundation

extension ShareSDK {

	typealias ShareSDKShareComplete = ((_: Bool, _: [String: Any]) -> Void)

	static func shareTo(_ platform: SSDKPlatformType, _ text: String?, _ image: Any?, _ url: URL?, _ title: String?, _ type: SSDKContentType, _ complete: ShareSDKShareComplete?) {
		guard handlerBreakWeiboWapLogin(platform, complete) == false else {
			return
		}
		let shareParames = createShareParameter(text, image, url, title, type)
		ShareSDK.share(platform, parameters: shareParames) { (state: SSDKResponseState, nil, entity: SSDKContentEntity?, error: Error?) in
			var issuccess = false
			switch state {
			case SSDKResponseState.success:
				if error == nil {
					issuccess = true
				}
			default:
				break
			}
			complete?(issuccess, [:])
		}
	}

	static func loginFrom(_ platform: SSDKPlatformType, _ complete: ShareSDKShareComplete?) {
		guard handlerBreakWeiboWapLogin(platform, complete) == false else {
			return
		}
		ShareSDK.cancelAuthorize(platform)
		ShareSDK.getUserInfo(platform) { (state, user, error) in
			var issuccess = false
			switch state {
			case SSDKResponseState.success:
				if let count = user?.rawData.count, count > 0 {
					issuccess = true
				}
			default:
				break
			}
			var userResult = user?.credential.rawData as? [String: Any] ?? [:]
			for (key, value) in user?.rawData as? [String: Any] ?? [:] {
				userResult[key] = value
			}
			complete?(issuccess, userResult)
		}
	}

	// weibo 的 web 登录会崩溃
	static func handlerBreakWeiboWapLogin(_ platform: SSDKPlatformType, _ complete: ShareSDKShareComplete?) -> Bool {
		if case .typeSinaWeibo = platform, ShareSDK.isClientInstalled(.typeSinaWeibo) == false {
			complete?(false, [String: Any]())
			return true
		}
		return false
	}

	static func createShareParameter(_ text: String?, _ image: Any?, _ url: URL?, _ title: String?, _ type: SSDKContentType) -> NSMutableDictionary {
		var title = title
		var text = text
		if (title?.count ?? 0) <= 0, (text?.count ?? 0) > 0 {
			title = text
		}
		if (text?.count ?? 0) <= 0, (title?.count ?? 0) > 0 {
			text = title
		}
		let shareParames = NSMutableDictionary()
		shareParames.ssdkSetupShareParams(byText: text,
										  images: image,
										  url: url,
										  title: title,
										  type: type)
		return shareParames
	}

}

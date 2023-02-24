//
//  Appdelegate+Register.swift
//  Tian
//
//  Created by hublot on 2018/11/19.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import MJExtension
import SnapKit
import Kingfisher
import HTButton

extension Appdelegate {
	
	func registerFramework(_ launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
    
		RCIM.shared()?.initWithAppKey("x4vkb1qpx7e5k")
		RCIM.shared()?.showUnkownMessage = true
		RCIM.shared()?.userInfoDataSource = self
		RCIM.shared()?.connect(withToken: HTUserAuthManager.userToken, success: { (userId) in
			print("")
		}, error: { (error) in
			print("")			
		}) { 
			print("")
		}

		ShareSDK.registerActivePlatforms([
			SSDKPlatformType.typeSinaWeibo.rawValue,
			SSDKPlatformType.typeWechat.rawValue,
			SSDKPlatformType.typeQQ.rawValue,
			], onImport: { (type) in
				switch type {
				case SSDKPlatformType.typeSinaWeibo:
					ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
				case SSDKPlatformType.typeWechat:
					ShareSDKConnector.connectWeChat(WXApi.classForCoder())
				case SSDKPlatformType.typeQQ:
					ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
				default:
					break
				}
		}) { (type, appInfo) in
			switch type {
			case SSDKPlatformType.typeSinaWeibo:
				let returnURL = "https://sns.whalecloud.com/sina2/callback"
				appInfo?.ssdkSetupSinaWeibo(byAppKey: "2760994873",
											appSecret: "ae1a29ed65b41c143d64bb376ba8871a",
											redirectUri: returnURL,
											authType: SSDKAuthTypeBoth)
			case SSDKPlatformType.typeWechat:
				appInfo?.ssdkSetupWeChat(byAppId: "wxc489256915ec49b7",
										 appSecret: "81839f186f7b9197495274f37d5e3a98",
										 backUnionID: false)
			case SSDKPlatformType.typeQQ:
				appInfo?.ssdkSetupQQ(byAppId: "100579784",
									 appKey: "42fef738bed10a5e9ce055b56972e84d",
									 authType: SSDKAuthTypeBoth, useTIM: true, backUnionID: true)
			default:
				break
			}
		}

		
	}
	
}

extension Appdelegate: RCIMUserInfoDataSource {
	
	func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
		
	}
	
}






extension Appdelegate {
    
    static func rootController() -> UIViewController? {
        return (UIApplication.shared.delegate as? Appdelegate)?.window?.rootViewController
    }
    
    static func navigationController() -> UINavigationController? {
        return (rootController() as? UITabBarController)?.selectedViewController as? UINavigationController
    }
    
}

//
//  HTSetupModel.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwiftNetwork

enum HTSetupType {
	case password
	case phonebind
    case phonecancel(_: String)
	case black
	case friend
	case notify
	case animation
	case cache
	case issue
	case policy
	case about
	case exit
}

class HTSetupModel: NSObject {
	
	var title: String?
	var type: HTSetupType?
	var text: String?
	var controllerClass: UIViewController.Type?
	var image: String?
	var selectedImage: String?
	var selected: Bool?
	
	var accessoryHidden: Bool?

	static let cacheFloder = Cacher.cacheFloder
	
	class func packModelArray(_ type: HTSetupSectionType?, _ showCache: Bool?) -> [HTSetupModel] {
		let titleKey = "titleKey"
		let typeKey = "typeKey"
		let textKey = "textKey"
		let controllerClassKey = "controllerClassKey"
		let imageKey = "imageKey"
		let selectedImageKey = "selectedImageKey"
		let selectedKey = "selectedKey"
		let accessoryHiddenKey = "accessoryHiddenKey"

		var sizeString = "0 MB"
		if showCache == true {
			sizeString = String.init(format: "%.2f MB", HTFileManager.floderSize(cacheFloder))
		}
		
		var keyValueArray = [[String: Any]]()
		switch type {
		case .user?:
            let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
			keyValueArray.append(contentsOf: [
				[titleKey: "修改密码", typeKey: HTSetupType.password, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
			])
            if (userInfoModel?.phone.count ?? 0) > 0 {
                keyValueArray.append(contentsOf: [
                    [titleKey: "解除手机绑定", typeKey: HTSetupType.phonecancel(userInfoModel?.phone ?? ""), textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
                ])
            } else {
                keyValueArray.append(contentsOf: [
                    [titleKey: "手机绑定", typeKey: HTSetupType.phonebind, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
                ])
            }
            keyValueArray.append(contentsOf: [
                [titleKey: "黑名单", typeKey: HTSetupType.black, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
                [titleKey: "好友设置", typeKey: HTSetupType.friend, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
            ])
		case .system?:
			keyValueArray.append(contentsOf: [
				[titleKey: "通知管理", typeKey: HTSetupType.notify, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
				[titleKey: "特效管理", typeKey: HTSetupType.animation, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
			])
		case .about?:
			keyValueArray.append(contentsOf: [
				[titleKey: "清理缓存", typeKey: HTSetupType.cache, textKey: sizeString, controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: true],
				[titleKey: "意见反馈", typeKey: HTSetupType.issue, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
				[titleKey: "用户协议与隐私政策", typeKey: HTSetupType.policy, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
				[titleKey: "关于本软件", typeKey: HTSetupType.about, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: false],
			])
		case .exit?:
			keyValueArray.append(contentsOf: [
				[titleKey: "退出登录", typeKey: HTSetupType.exit, textKey: "", controllerClassKey: UIViewController.self, imageKey: "", selectedImageKey: "", selectedKey: false, accessoryHiddenKey: true],
			])
		default:
			break
		}
		let modelArray = keyValueArray.map { dictionary -> HTSetupModel in
			let model = HTSetupModel()
			model.title = dictionary[titleKey] as? String
			model.type = dictionary[typeKey] as? HTSetupType
			model.text = dictionary[textKey] as? String
			model.controllerClass = dictionary[controllerClassKey] as? UIViewController.Type
			model.image = dictionary[imageKey] as? String
			model.selected = dictionary[selectedKey] as? Bool
			model.selectedImage = dictionary[selectedImageKey] as? String
			model.accessoryHidden = dictionary[accessoryHiddenKey] as? Bool
			return model
		}
		return modelArray
	}
}

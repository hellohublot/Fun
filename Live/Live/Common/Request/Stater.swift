//
//  Stater.swift
//  Shop
//
//  Created by hublot on 2018/3/31.
//  Copyright © 2018年 hublot. All rights reserved.
//

import UIKit
import HTSwift

open class Stater: StateProvider {
	open var defaultTitle = ""
	open var resumeTitle: String?
	open var errorTitle: String?
	
	public func beresume(_ session: HTSwift.Session) {
		guard let resumeTitle = self.resumeTitle else {
			return
		}
		HTHud.show(withStatus: resumeTitle.count > 0 ? resumeTitle : "加载中...")
	}
	
	public func besuspend(_ session: HTSwift.Session) {
		HTHud.dismiss()
	}
	
	public func becomplete(_ session: HTSwift.Session, _ result: HTSwift.Result?) {
		guard let errorTitle = self.errorTitle else {
			return
		}
		HTHud.dismiss()
		guard result?.data == nil, result?.value == nil else {
			return
		}
		HTHud.showError(withStatus: errorTitle.count > 0 ? errorTitle : result?.error.localizedDescription)
	}

}

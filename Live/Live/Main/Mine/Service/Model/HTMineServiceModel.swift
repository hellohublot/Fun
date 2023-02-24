//
//  HTMineServiceModel.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineServiceModel: NSObject {
	
	@objc var title = ""
	@objc var qq = ""
	@objc var level = 0
	@objc var comment = ""
	
	@objc var image = "87fd8add08df9a0011325aa83544a036"
	
	static func packPhoneModel() -> HTMineServiceModel {
		let model = HTMineServiceModel()
		model.title = "010-64366647"
		model.image = "65b02cbd5dcbfd212eb8ea02d9231f9f"
		return model
	}

}

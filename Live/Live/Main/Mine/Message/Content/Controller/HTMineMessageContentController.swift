//
//  HTMineMessageContentController.swift
//  Live
//
//  Created by hublot on 2019/1/9.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineMessageContentController: RCConversationListViewController {

	
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		setDisplayConversationTypes([
			RCConversationType.ConversationType_PRIVATE.rawValue,
			RCConversationType.ConversationType_SYSTEM.rawValue
		])
	}
	
	func initInterface() {
		
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func willReloadTableData(_ dataSource: NSMutableArray!) -> NSMutableArray! {
		print("")
		return dataSource
	}
	
	override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
		let conversationController = RCConversationViewController.init()
		conversationController.conversationType = model.conversationType
		conversationController.targetId = model.targetId
		conversationController.title = model.conversationTitle
		navigationController?.pushViewController(conversationController, animated: true)
	}

}


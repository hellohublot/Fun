//
//  HTDiscoverNewsFollowController.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwiftRefresh

class HTDiscoverNewsFollowController: HTDiscoverNewsContentController {
	
	override func initDataSource() {
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.discoverNewsFollowList(pageIndex - 1, { (result) in
				self?.reloadResponseValue(pageIndex, result, nil)
			})
		}
		tableView.respondHeaderRefresh()
	}

}

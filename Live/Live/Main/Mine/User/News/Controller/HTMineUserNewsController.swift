//
//  HTMineUserNewsController.swift
//  Live
//
//  Created by hublot on 2019/1/19.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh

class HTMineUserNewsController: HTDiscoverNewsContentController, HTMineUserContentControllerAble {

	var uidString = ""

	var reloadSuperControllerHeightBlock: ((CGFloat) -> Void)?

	override func initDataSource() {
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.userDetailNewsList(self?.uidString ?? "", pageIndex - 1, { (result) in
				self?.reloadResponseValue(pageIndex, result, {
					self?.reloadSuperControllerHeightBlock?(self?.tableView.contentSize.height ?? 0)
				})
			})
		}
	}

	override func initInterface() {
		super.initInterface()
		tableView.isScrollEnabled = false
	}

	func requestModelArray(_ isHeaderRefresh: Bool) {
		if isHeaderRefresh {
			if tableView.cellModelArray().count <= 0 {
				tableView.respondHeaderRefresh()
			} else {
				reloadSuperControllerHeightBlock?(tableView.contentSize.height)
			}
		} else {
			let footer: MJRefreshFooter? = tableView.mj_footer
			guard let refreshFooter = footer else {
				return
			}
			if tableView.cellModelArray().count > 0, refreshFooter.state != .noMoreData, refreshFooter.isRefreshing == false {
				refreshFooter.beginRefreshing()
			}
		}
	}

}

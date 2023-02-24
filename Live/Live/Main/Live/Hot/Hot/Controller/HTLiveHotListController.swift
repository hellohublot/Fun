//
//  HTLiveHotListController.swift
//  Live
//
//  Created by hublot on 2019/1/31.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh

class HTLiveHotListController: HTLiveHotContentController {

	override func initDataSource() {
		collectionView.pageCount = 30
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.hotRoomList(pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: value["hot"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
				if pageIndex == 1 {
					self?.collectionView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.collectionView.cellModelArray() as? [HTLiveContentModel] ?? [HTLiveContentModel]()
					existModelArray += modelArray
					self?.collectionView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
		collectionView.respondHeaderRefresh()
	}

	override func initInterface() {
		super.initInterface()
		navigationItem.title = "热门主播"
	}

}

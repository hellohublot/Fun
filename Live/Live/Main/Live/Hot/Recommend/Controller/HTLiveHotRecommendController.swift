//
//  HTLiveHotRecommendController.swift
//  Live
//
//  Created by hublot on 2019/1/31.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveHotRecommendController: HTLiveHotContentController {

	var recommendModelArray = [Any]()

	override func initDataSource() {
		collectionView.placeholderState = .firstRefresh
		collectionView.setCellModelArray(recommendModelArray, proxy: self)
		collectionView.endRefreshWithOnlyOnePage(modelCount: recommendModelArray.count)
		collectionView.reloadData()
	}

	override func initInterface() {
		super.initInterface()
		navigationItem.title = "推荐主播"
	}

}

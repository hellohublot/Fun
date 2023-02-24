//
//  HTLiveHotNewController.swift
//  Live
//
//  Created by hublot on 2019/1/31.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveHotNewController: HTLiveHotContentController {

	var newModelArray = [Any]()

	override func initDataSource() {
		collectionView.placeholderState = .firstRefresh
		collectionView.setCellModelArray(newModelArray, proxy: self)
		collectionView.endRefreshWithOnlyOnePage(modelCount: newModelArray.count)
		collectionView.reloadData()
	}

	override func initInterface() {
		super.initInterface()
		navigationItem.title = "优质新人"
	}

}

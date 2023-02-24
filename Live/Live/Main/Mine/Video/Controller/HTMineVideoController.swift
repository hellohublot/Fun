//
//  HTMineVideoController.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineVideoController: UIViewController {
	
	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.placeholderProvider = Placeholder.default
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			let userInfoModel = HTMineUserInfoModel.mj_object(withKeyValues: HTUserAuthManager.userInfo)
			Request.list.userDetailVideoList(userInfoModel?.uid ?? "", pageIndex - 1, { (result) in
				guard let value = result.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTVideoContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTVideoContentModel] ?? [HTVideoContentModel]()
				if pageIndex == 1 {
					self?.collectionView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.collectionView.cellModelArray() as? [HTVideoContentModel] ?? [HTVideoContentModel]()
					existModelArray += modelArray
					self?.collectionView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.collectionView.reloadData()
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
			})
		}
		collectionView.respondHeaderRefresh()
	}
	
	func initInterface() {
		navigationItem.title = "我的小视频"
		let cameraButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "bf888700371c39409d5d0ef63822e753")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cameraButtonItemResponse))
		navigationItem.rightBarButtonItem = cameraButtonItem
		view.addSubview(collectionView)
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	@objc func cameraButtonItemResponse() {
		let recordController = HTVideoRecordController()
        recordController.modalPresentationStyle = .fullScreen
		present(recordController, animated: true, completion: nil)
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/


}

extension HTMineVideoController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineUserVideoCell.self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func itemWidthFromItemSingleColumnCount(_ count: Int, _ section: Int) -> CGFloat {
		var width = collectionView.frame.size.width
		let sectionInset = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumInteritemWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
		width -= (sectionInset.left + sectionInset.right)
		width -= (CGFloat(count - 1) * minimumInteritemWidth)
		return floor(width / CGFloat(count))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 270)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
	}
	
}


//
//  HTLiveContentController.swift
//  Live
//
//  Created by hublot on 2018/12/26.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTLiveContentController: UIViewController {

	var cellAnimationEnable = true

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		return collectionView
	}()

	var pageType: HTLivePageType?
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
	
	}
	
	func initInterface() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: 0, right: 0))
		}
	}
	
	func reloadModelArrayWithType(_ type: HTLivePageType?) {
		guard case .content(let (categoryId, _))? = type else {
			return
		}
		pageType = type
		collectionView.pageCount = 20
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.liveList(categoryId, pageIndex - 1, { (result) in
				guard let value = result.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = (HTLiveContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTLiveContentModel]) ?? [HTLiveContentModel]()
				if pageIndex == 1 {
					self?.collectionView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = (self?.collectionView.cellModelArray() as? [HTLiveContentModel]) ?? [HTLiveContentModel]()
					existModelArray += modelArray
					self?.collectionView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.cellAnimationEnable = false
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
				DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(100), execute: {
					self?.cellAnimationEnable = true
				})
			})
		}
		collectionView.respondHeaderRefresh()
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}


extension HTLiveContentController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveContentCell.self
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
		var height: CGFloat = 0
		if case .content(let (_, itemHeight))? = pageType {
			height = itemHeight
		}
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard cellAnimationEnable else {
			return
		}
		cell.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
		UIView.animate(withDuration: 0.5) {
			cell.transform = CGAffineTransform.identity
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let model = collectionView.cellModelArray()[indexPath.row] as? HTLiveContentModel
		let detailController = HTLiveDetailController()
		detailController.roomIdString = model?.rid
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}
	
}

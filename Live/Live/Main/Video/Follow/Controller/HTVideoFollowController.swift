//
//  HTVideoFollowController.swift
//  Live
//
//  Created by hublot on 2019/1/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTVideoFollowController: UIViewController, HTVideoRefreshController {
	
	weak var delegate: HTVideoRefreshProtocol?

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.bounces = false
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
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			if pageIndex == 1 {
				self?.delegate?.setRefresh(true, animated: true)
			}
			Request.list.followVideoList(pageIndex - 1, { (result) in
				if pageIndex == 1 {
					self?.delegate?.setRefresh(false, animated: true)
				}
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
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
		collectionView.respondHeaderRefresh()
	}
	
	func initInterface() {
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
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTVideoFollowController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y <= 0, scrollView.panGestureRecognizer.velocity(in: scrollView).y > 10 {
			collectionView.respondHeaderRefresh()
		}
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTVideoFollowCell.self
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
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 250)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
}

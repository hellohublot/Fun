//
//  HTMineStoreNumberController.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineStoreNumberController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTMineStoreNumberSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTMineStoreNumberSectionHeaderView.identifier)
		return collectionView
	}()

	var responseValue = [String: Any]()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.shopNumberList({ (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				self?.responseValue = value
				self?.reloadSelectedPageIndex(0)
			})
		}
		collectionView.respondHeaderRefresh()
	}

	func initInterface() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	func reloadSelectedPageIndex(_ selectedPageIndex: Int) {
		let modelArray = HTMineStoreNumberSectionModel.packModelArray(responseValue, selectedPageIndex)
		collectionView.setSectionModelArray(modelArray, proxy: self)
		collectionView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
		collectionView.reloadData()
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}

extension HTMineStoreNumberController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineStoreNumberCell.self
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section]
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HTMineStoreNumberSectionHeaderView.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		(cell as? HTMineStoreNumberSectionHeaderView)?.cellDidSelected = { [weak self] (selectedIndex) in
			self?.reloadSelectedPageIndex(selectedIndex)
		}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.init(width: collectionView.bounds.size.width, height: 90)
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
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 100)
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

}

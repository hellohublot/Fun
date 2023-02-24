//
//  HTMineStoreSeatController.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineStoreSeatController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTMineStoreSeatRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTMineStoreSeatRecommendHeaderView.identifier)
		collectionView.register(HTMineStoreSeatPageHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTMineStoreSeatPageHeaderView.identifier)		
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
			Request.list.shopCarList({ (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTMineStoreSeatSectionModel.packModelArray(value, 0)
				self?.collectionView.setSectionModelArray(modelArray, proxy: self)
				self?.collectionView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
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

extension HTMineStoreSeatController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .recommend?:
			return HTMineStoreSeatRecommendView.self
		case .page?:
			return HTMineStoreSeatCell.self
		default:
			return HTMineStoreSeatCell.self
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreSeatSectionModel
		var reuseClass: ReuseCell.Type
		switch sectionModel?.type {
		case .recommend?:
			reuseClass = HTMineStoreSeatRecommendHeaderView.self
		case .page?:
			reuseClass = HTMineStoreSeatPageHeaderView.self
		default:
			reuseClass = HTMineStoreSeatRecommendHeaderView.self
		}
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .recommend?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 55)
		case .page?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 60)
		default:
			return CGSize.zero
		}
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .recommend?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 200)
		case .page?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 180)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .page?:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .page?:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreSeatSectionModel
		switch sectionModel?.type {
		case .recommend?:
			return UIEdgeInsets.init(top: 0, left: 0, bottom: 15, right: 0)
		case .page?:
			return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
		default:
			return UIEdgeInsets.zero
		}
	}

	
}

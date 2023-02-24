//
//  HTDiscoverController.swift
//  Live
//
//  Created by hublot on 2018/12/25.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTDiscoverSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTDiscoverSectionHeaderView.identifier)
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		collectionView.pageCount = 20
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.liveList("17", pageIndex - 1, { (newResult) in
				guard let newValue = newResult.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: newValue) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
				if pageIndex == 1 {
					Request.list.hotList({ (hotResult) in
						guard let hotValue = hotResult.value as? [Any] else {
							self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
							return
						}
						let hotModelArray = [HTDiscoverNewsContentModel.mj_objectArray(withKeyValuesArray: hotValue)]
						Request.list.bannerList({ (bannerResult) in
							guard let bannerValue = bannerResult.value as? [Any] else {
								self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
								return
							}
							let bannerModelArray = [HTLiveHotBannerModel.mj_objectArray(withKeyValuesArray: bannerValue)]
							let sectionModelArray = HTDiscoverSectionModel.packModelArray(bannerModelArray, hotModelArray, modelArray)
							self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
							self?.collectionView.endRefreshWith(modelCount: modelArray.count)
							self?.collectionView.reloadData()
						})
					})
				} else {
					let bannerModelArray = HTDiscoverSectionModel.findModelArrayFromSectionModelArray(self?.collectionView.sectionModelArray(), .banner) 
					let hotModelArray = HTDiscoverSectionModel.findModelArrayFromSectionModelArray(self?.collectionView.sectionModelArray(), .hot)
					var existModelArray = HTDiscoverSectionModel.findModelArrayFromSectionModelArray(self?.collectionView.sectionModelArray(), .new) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
					existModelArray += modelArray
					let sectionModelArray = HTDiscoverSectionModel.packModelArray(bannerModelArray, hotModelArray, existModelArray) 
					self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
					self?.collectionView.endRefreshWith(modelCount: modelArray.count)
					self?.collectionView.reloadData()
				}
			})
		}
		collectionView.respondHeaderRefresh()
	}
	
	func initInterface() {
		navigationItem.title = "发现"
		let searchBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "2881a1a684850f0e986afd2ab8fba40b")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchBarButtonResponse))
		navigationItem.rightBarButtonItem = searchBarButtonItem
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	@objc func searchBarButtonResponse() {
		let searchController = HTLiveSearchController()
		navigationController?.pushViewController(searchController, animated: true)
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTDiscoverController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .banner?:
			return HTDiscoverBannerView.self
		case .circle?:
			return HTDiscoverCircleCell.self
		case .hot?:
			return HTDiscoverHotView.self
		case .new?:
			return HTDiscoverNewCell.self
		default:
			return HTDiscoverNewCell.self
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverSectionModel
		var reuseClass: ReuseCell.Type
		switch sectionModel?.type {
		case .hot?, .new?:
			reuseClass = HTDiscoverSectionHeaderView.self
		default:
			reuseClass = HTDiscoverSectionHeaderView.self
		}
		let reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(reuseView as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return reuseView
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .hot?, .new?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 45)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize.zero
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .banner?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 140)
		case .circle?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(4, indexPath.section), height: 80)			
		case .hot?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 150)			
		case .new?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(3, indexPath.section), height: 112)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .new?:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .new?:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverSectionModel
		switch sectionModel?.type {
		case .banner?:
			return UIEdgeInsets.init(top: 0, left: 0, bottom: 20, right: 0)
		case .circle?:
			return UIEdgeInsets.init(top: 0, left: 10, bottom: 30, right: 10)
		case .hot?:
			return UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
		case .new?:
			return UIEdgeInsets.init(top: 7, left: 10, bottom: 7, right: 10)
		default:
			return UIEdgeInsets.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverSectionModel
		var willController: UIViewController?
		switch sectionModel?.type {
		case .circle?:
			let model = sectionModel?.modelArray[indexPath.row] as? HTDiscoverCircleModel
			switch model?.type {
			case .home?:
				willController = HTDiscoverHomeController()
			case .activity?:
				willController = HTDiscoverActivityController()
			case .game?:
				willController = HTDiscoverGameController()
			case .rank?:
				willController = HTDiscoverRankController()
			default:
				break
			}
		case .new?:
			let model = sectionModel?.modelArray[indexPath.row] as? HTLiveContentModel
			let detailController = HTLiveDetailController()
			detailController.roomIdString = model?.rid
            detailController.modalPresentationStyle = .fullScreen
			Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
		default:
			break
		}
		if let willController = willController {
			navigationController?.pushViewController(willController, animated: true)
		}
	}
	
}

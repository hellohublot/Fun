//
//  HTLiveNearController.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder
import CoreLocation

class HTLiveNearController: UIViewController {

	lazy var locationManager: HTLiveNearLocationManager = {
		let locationManager = HTLiveNearLocationManager.init()
		return locationManager
	}()

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTLiveNearSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTLiveNearSectionHeaderView.identifier)
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
			Request.list.nearList(HTLiveNearCityModel.packCurrentCityModel(true)?.id ?? "1" ,pageIndex - 1, { (result) in
				guard let value = result.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = (HTLiveContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTLiveContentModel]) ?? [HTLiveContentModel]()
				for model in modelArray {
					model.showCityTitle = true
				}
				if pageIndex == 1 {
					self?.collectionView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = (self?.collectionView.cellModelArray() as? [HTLiveContentModel]) ?? [HTLiveContentModel]()
					existModelArray += modelArray
					self?.collectionView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.collectionView.endRefreshWith(modelCount: max(modelArray.count, 1))
				self?.collectionView.reloadData()
			})
		}

		locationManagerDidChange()

		NotificationCenter.default.addObserver(self, selector: #selector(locationManagerDidChange), name: HTLiveNearLocationManager.locationNotification, object: nil)
		locationManager.startUpdatingLocation()

	}

	func initInterface() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: 0, right: 0))
		}
	}

	@objc func locationManagerDidChange() {
		collectionView.respondHeaderRefresh()
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension HTLiveNearController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveContentCell.self
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HTLiveNearSectionHeaderView.identifier, for: indexPath)
		(reuseView as? HTLiveNearSectionHeaderView)?.setModel(nil, for: indexPath)
		return reuseView
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let headerHeight: CGFloat = HTLiveNearLocationManager.locationAuthorization ? 45 : 140
		return CGSize.init(width: collectionView.bounds.size.width, height: headerHeight)
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
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 200)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let model = collectionView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTLiveContentModel
		let detailController = HTLiveDetailController()
		detailController.roomIdString = model?.rid
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}

}


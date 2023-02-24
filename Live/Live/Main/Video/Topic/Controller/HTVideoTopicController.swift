//
//  HTVideoTopicController.swift
//  Live
//
//  Created by hublot on 2019/1/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTVideoTopicController: UIViewController, HTVideoRefreshController {
	
	weak var delegate: HTVideoRefreshProtocol?

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.register(HTVideoTopicHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTVideoTopicHeaderView.identifier)
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
			Request.list.topicVideoList(pageIndex - 1, { (result) in
				guard let value = result.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let sectionModelArray = HTVideoTopicSectionModel.mj_objectArray(withKeyValuesArray: value) as? [HTVideoTopicSectionModel] ?? [HTVideoTopicSectionModel]()
				if pageIndex == 1 {
					self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
				} else {
					var existModelArray = self?.collectionView.sectionModelArray() as? [HTVideoTopicSectionModel] ?? [HTVideoTopicSectionModel]()
					existModelArray += sectionModelArray
					self?.collectionView.setSectionModelArray(existModelArray, proxy: self)
				}
				self?.collectionView.endRefreshWith(modelCount: sectionModelArray.count)
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
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: 0, right: 0))
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTVideoTopicController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTVideoTopicView.self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTVideoTopicSectionModel
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HTVideoTopicHeaderView.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.init(width: collectionView.bounds.size.width, height: 50)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize.init(width: collectionView.bounds.size.width, height: 230)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
}

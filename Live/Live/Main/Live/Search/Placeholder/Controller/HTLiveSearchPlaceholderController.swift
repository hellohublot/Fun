//
//  HTLiveSearchPlaceholderController.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftPlaceholder

class HTLiveSearchPlaceholderController: UIViewController {

	var placeholderHistoryResponse: ((_: String) -> Void)?

	lazy var collectionView: UICollectionView = {
		let flowLayout = HTLeftAlignFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTLiveSearchPlaceholderSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTLiveSearchPlaceholderSectionHeaderView.identifier)
		return collectionView
	}()
	
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
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	func reloadPlaceholderModelArray() {
		collectionView.placeholderState = .firstRefresh
		Request.list.searchRecommendList { [weak self] (result) in
			let value = result.value as? [Any] ?? [Any]()
			let sectionModelArray = HTLiveSearchPlaceholderSectionModel.packModelArray(value)
			self?.collectionView.placeholderState = sectionModelArray.count > 0 ? .none : .nothingDisplay
			self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
			self?.collectionView.reloadData()
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTLiveSearchPlaceholderController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			return HTLiveSearchPlaceholderHistoryCell.self
		case .recommend?:
			return HTLiveContentCell.self
		default:
			return HTLiveContentCell.self
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveSearchPlaceholderSectionModel
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HTLiveSearchPlaceholderSectionHeaderView.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		(cell as? HTLiveSearchPlaceholderSectionHeaderView)?.detailButton.whenTouch(inside: { [weak self] (_, _) in
			HTLiveSearchPlaceholderHistoryModel.clearHistory()
			self?.reloadPlaceholderModelArray()
		})
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.init(width: collectionView.bounds.size.width, height: 50)
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			if let model = sectionModel?.modelArray[indexPath.row] as? NSObject {
				let size = HTLiveSearchPlaceholderHistoryCell.cacheModelSize(model, CGSize.init(width: 0, height: 32))
				return size
			}
			return CGSize.zero
		case .recommend?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 200)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			return 10
		case .recommend?:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			return 10
		case .recommend?:
			return 10
		default:
			return 0
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			return UIEdgeInsets.init(top: 0, left: 10, bottom: 30, right: 10)
		case .recommend?:
			return UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10)
		default:
			return UIEdgeInsets.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveSearchPlaceholderSectionModel
		switch sectionModel?.type {
		case .history?:
			let historyModel = sectionModel?.modelArray[indexPath.row] as? HTLiveSearchPlaceholderHistoryModel
			placeholderHistoryResponse?(historyModel?.title ?? "")
		case .recommend?:
			let recommendModel = sectionModel?.modelArray[indexPath.row] as? HTLiveContentModel
			let detailController = HTLiveDetailController()
			detailController.roomIdString = recommendModel?.rid
            detailController.modalPresentationStyle = .fullScreen
			Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
		default:
			break
		}
	}
	
}

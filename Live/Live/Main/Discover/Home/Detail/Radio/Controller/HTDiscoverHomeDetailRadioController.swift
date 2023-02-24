//
//  HTDiscoverHomeDetailRadioController.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeDetailRadioController: UIViewController {

	var homeIdString = ""

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
		collectionView.pageCount = 14
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.homeRadioList(self?.homeIdString ?? "", pageIndex - 1, { (result) in
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
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
		collectionView.respondHeaderRefresh()
	}

	func initInterface() {
		navigationItem.title = "家族主播"
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}

extension HTDiscoverHomeDetailRadioController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

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
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 200)
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

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let model = collectionView.cellModelArray()[indexPath.row] as? HTLiveContentModel
		let detailController = HTLiveDetailController()
		detailController.roomIdString = model?.rid
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}

}


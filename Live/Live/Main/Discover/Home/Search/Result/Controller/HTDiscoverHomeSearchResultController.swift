//
//  HTDiscoverHomeSearchResultController.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeSearchResultController: UIViewController {


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

	}

	func initInterface() {
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	func reloadResultModelArrayWithText(_ text: String) {

		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.homeSearch(text, pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTDiscoverHomeModel.mj_objectArray(withKeyValuesArray: value["familyList"]) as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
				for model in modelArray {
					model.showFlagImage = false
				}
				if pageIndex == 1 {
					self?.collectionView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.collectionView.cellModelArray() as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
					existModelArray += modelArray
					self?.collectionView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
		collectionView.mj_header?.isHidden = true
		collectionView.respondHeaderRefresh()

	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension HTDiscoverHomeSearchResultController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTDiscoverHomeRecommendCell.self
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

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize.init(width: collectionView.bounds.size.width, height: 100)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let model = collectionView.cellModelArray()[indexPath.row] as? HTDiscoverHomeModel
		let detailController = HTDiscoverHomeDetailController()
		detailController.homeIdString = model?.fid ?? ""
		Appdelegate.navigationController()?.pushViewController(detailController, animated: true)
	}


}

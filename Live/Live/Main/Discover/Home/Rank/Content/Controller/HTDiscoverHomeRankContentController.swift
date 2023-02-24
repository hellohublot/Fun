//
//  HTDiscoverHomeRankContentController.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftPlaceholder

class HTDiscoverHomeRankContentController: UIViewController {

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
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	func reloadRankContentModelArrayWithModel(_ pageModel: HTDiscoverHomeRankPageModel?) {
		collectionView.placeholderState = .firstRefresh
		Request.list.homeRankList(pageModel?.type?.rawValue ?? "") { (result) in
			var keyValueList = [[String: Any]]()
			if let value = result.value as? [String: Any] {
				keyValueList = value[HTDiscoverRankPopModel.findSelectedModel(pageModel?.rankPopModelArray)?.type?.rawValue ?? ""] as? [[String: Any]] ?? [[String: Any]]()
			} else if let value = result.value as? [Any] {
				keyValueList = value as? [[String: Any]] ?? [[String: Any]]()
			} else {
				self.collectionView.placeholderState = .errorNetwork
				return
			}
			let modelArray = HTDiscoverHomeModel.mj_objectArray(withKeyValuesArray: keyValueList) as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
			self.collectionView.placeholderState = modelArray.count > 0 ? .none : .nothingDisplay
			self.collectionView.setCellModelArray(modelArray, proxy: self)
			self.collectionView.reloadData()
		}

	}

	/*-------------------------------------/ controller override /-----------------------------------*/


}



extension HTDiscoverHomeRankContentController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

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

	func itemWidthFromItemSingleColumnCount(_ count: Int, _ section: Int) -> CGFloat {
		var width = collectionView.frame.size.width
		let sectionInset = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumInteritemWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
		width -= (sectionInset.left + sectionInset.right)
		width -= (CGFloat(count - 1) * minimumInteritemWidth)
		return floor(width / CGFloat(count))
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

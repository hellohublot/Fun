//
//  HTDiscoverHomeController.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTDiscoverHomeCircleHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTDiscoverHomeCircleHeaderView.identifier)
		collectionView.register(HTDiscoverHomeRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTDiscoverHomeRecommendHeaderView.identifier)
		return collectionView
	}()
    
    var userFamilyIdString = ""

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		collectionView.pageCount = 14
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.homeList(pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTDiscoverHomeModel.mj_objectArray(withKeyValuesArray: value["familyList"]) as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
				if pageIndex == 1 {
                    self?.userFamilyIdString = ((value["userFamily"] as? [String: Any])?["fid"] as? String) ?? ""
					let sectionModelArray = HTDiscoverHomeSectionModel.packModelArray(modelArray)
					self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
				} else {
					var existModelArray = HTDiscoverHomeSectionModel.findModelArrayWithType(self?.collectionView.sectionModelArray() ?? [Any](), .recommend) as? [HTDiscoverHomeModel] ?? [HTDiscoverHomeModel]()
					existModelArray += modelArray
					let sectionModelArray = HTDiscoverHomeSectionModel.packModelArray(existModelArray)
					self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
				}
				self?.collectionView.endRefreshWith(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
		collectionView.respondHeaderRefresh()
	}

	func initInterface() {
		navigationItem.title = "家族"
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}

extension HTDiscoverHomeController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeSectionModel
		switch sectionModel?.type {
		case .circle?:
			return HTDiscoverHomeCircleCell.self
		case .recommend?:
			return HTDiscoverHomeRecommendCell.self
		default:
			return HTDiscoverHomeRecommendCell.self
		}
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeSectionModel
		var reuseClass: ReuseCell.Type
		switch sectionModel?.type {
		case .circle?:
			reuseClass = HTDiscoverHomeCircleHeaderView.self
		case .recommend?:
			reuseClass = HTDiscoverHomeRecommendHeaderView.self
		default:
			reuseClass = HTDiscoverHomeRecommendHeaderView.self
		}
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverHomeSectionModel
		switch sectionModel?.type {
		case .circle?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 45)
		case .recommend?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 50)
		default:
			return CGSize.zero
		}
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeSectionModel
		switch sectionModel?.type {
		case .circle?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 95)
		default:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 100)
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverHomeSectionModel
		switch sectionModel?.type {
		case .circle?:
			return UIEdgeInsets.init(top: 5, left: 5, bottom: 0, right: 5)
		default:
			return UIEdgeInsets.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeSectionModel
		var willController: UIViewController?
		switch sectionModel?.type {
		case .circle?:
			let model = sectionModel?.modelArray[indexPath.row] as? HTDiscoverHomeCircleModel
			switch model?.type {
            case .mine?:
                guard userFamilyIdString.count > 0 else {
                    HTHud.showError(withStatus: "你还没有加入家族")
                    break
                }
                let detailController = HTDiscoverHomeDetailController()
                detailController.homeIdString = userFamilyIdString
                willController = detailController
			case .rank?:
				willController = HTDiscoverHomeRankController()
			default:
				break
			}
		case .recommend?:
			let model = sectionModel?.modelArray[indexPath.row] as? HTDiscoverHomeModel
			let detailController = HTDiscoverHomeDetailController()
			detailController.homeIdString = model?.fid ?? ""
			willController = detailController
		default:
			break
		}
		if let willController = willController {
			navigationController?.pushViewController(willController, animated: true)
		}
	}


}

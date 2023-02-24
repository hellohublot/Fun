//
//  HTLiveHotController.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTLiveHotController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTLiveHotSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTLiveHotSectionHeaderView.identifier)
		collectionView.register(HTLiveHotRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HTLiveHotRecommendFooterView.identifier)
		return collectionView
	}()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		collectionView.pageCount = 30
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.mainBanner({ (bannerResult) in
				guard let bannerValue = bannerResult.value as? [Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let bannerModelArray = [HTLiveHotBannerModel.mj_objectArray(withKeyValuesArray: bannerValue) as? [HTLiveHotBannerModel] ?? [HTLiveHotBannerModel]()]
				if pageIndex == 1 {
					Request.list.mainList({ (mainResult) in
						guard let mainValue = mainResult.value as? [String: Any] else {
							self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
							return
						}
						let scrollModelArray = [HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["excelRecommend"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()]
                        
						var recommendModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["recommend"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
                        
                        recommendModelArray.append(contentsOf: (HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["room666"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()).map({ (contentModel) -> HTLiveContentModel in
                            contentModel.is666 = 1
                            return contentModel
                        }))
                        recommendModelArray.append(contentsOf: (HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["room999"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()).map({ (contentModel) -> HTLiveContentModel in
                            contentModel.is999 = 1
                            return contentModel
                        }))
                        for contentModel in recommendModelArray {
                            contentModel.mj_keyValuesDidFinishConvertingToObject()
                        }
                        
                        
						let newModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["newRecommend"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
						let hotModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: mainValue["hot"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
						let sectionModelArray = HTLiveHotSectionModel.packModelArray(scrollModelArray, recommendModelArray, bannerModelArray, newModelArray, hotModelArray)
						self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
						self?.collectionView.endRefreshWith(modelCount: hotModelArray.count)
						self?.collectionView.reloadData()
					})
				} else {
					Request.list.mainHot(pageIndex - 1, { (hotResult) in
						guard let hotValue = hotResult.value as? [String: Any] else {
							self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
							return
						}
						let hotModelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: hotValue["hot"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
						let scrollModelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(false, self?.collectionView.sectionModelArray(), .scroll)
						let recommendModelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(false, self?.collectionView.sectionModelArray(), .recommend)
						let newModelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(false, self?.collectionView.sectionModelArray(), .new)
						var existHotModelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(false, self?.collectionView.sectionModelArray(), .hot) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
						existHotModelArray += hotModelArray
						let sectionModelArray = HTLiveHotSectionModel.packModelArray(scrollModelArray, recommendModelArray, bannerModelArray, newModelArray, existHotModelArray)
						self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
						self?.collectionView.endRefreshWith(modelCount: hotModelArray.count)
						self?.collectionView.reloadData()
					})
				}
			})
		}
		collectionView.respondHeaderRefresh()

	}

	func initInterface() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: 0, right: 0))
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}


extension HTLiveHotController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .scroll?:
			return HTLiveHotScrollView.self
		case .recommend?, .new?, .hot?:
			return HTLiveContentCell.self
		case .banner?:
			return HTLiveHotBannerView.self
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveHotSectionModel
		var reuseClass: ReuseCell.Type
		switch kind {
		case UICollectionElementKindSectionHeader:
			reuseClass = HTLiveHotSectionHeaderView.self
		case UICollectionElementKindSectionFooter:
			reuseClass = HTLiveHotRecommendFooterView.self
		default:
			reuseClass = HTLiveHotSectionHeaderView.self
		}
		let reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(reuseView as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		(reuseView as? HTLiveHotSectionHeaderView)?.detailButton.whenTouch(inside: { [weak self] (_, _) in
			self?.sectionHeaderViewDetailButtonResponse(sectionModel)
		})
		(reuseView as? HTLiveHotRecommendFooterView)?.titleButton.whenTouch(inside: { [weak self] (_, _) in
			self?.sectionFooterViewTitleButtonResponse(sectionModel)
		})
		return reuseView
	}

	func sectionHeaderViewDetailButtonResponse(_ sectionModel: HTLiveHotSectionModel?) {
		switch sectionModel?.type {
		case .recommend?:
			let sectionModelArray = collectionView.sectionModelArray()
			HTLiveHotSectionModel.replaceRecommendSectionModelArray(sectionModelArray)
			collectionView.setSectionModelArray(sectionModelArray, proxy: self)
			for (index, sectionModel) in (sectionModelArray as? [HTLiveHotSectionModel] ?? [HTLiveHotSectionModel]()).enumerated() {
				if case .recommend? = sectionModel.type {
					collectionView.reloadSections([index])
					break
				}
			}
		case .new?:
			let modelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(true, collectionView.sectionModelArray(), .new)
			let newController = HTLiveHotNewController()
			newController.newModelArray = modelArray
			Appdelegate.navigationController()?.pushViewController(newController, animated: true)
		case .hot?:
			let hotController = HTLiveHotListController()
			Appdelegate.navigationController()?.pushViewController(hotController, animated: true)
		default:
			break
		}
	}

	func sectionFooterViewTitleButtonResponse(_ sectionModel: HTLiveHotSectionModel?) {
		switch sectionModel?.type {
		case .recommend?:
			let modelArray = HTLiveHotSectionModel.findModelArrayFromSectionModelArray(true, collectionView.sectionModelArray(), .recommend)
			let recommendController = HTLiveHotRecommendController()
			recommendController.recommendModelArray = modelArray
			Appdelegate.navigationController()?.pushViewController(recommendController, animated: true)
		default:
			break
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .recommend?, .new?, .hot?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 45)
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .scroll?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 150)
		case .recommend?, .new?, .hot?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 200)
		case .banner?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 110)
		default:
			return CGSize.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .recommend?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 65)
		default:
			return CGSize.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .recommend?, .new?, .hot?:
			return 8
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .recommend?, .new?, .hot?:
			return 8
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveHotSectionModel
		switch sectionModel?.type {
		case .scroll?:
			return UIEdgeInsets.init(top: 10, left: 0, bottom: 20, right: 0)
		case .recommend?, .new?, .hot?:
			return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
		case .banner?:
			return UIEdgeInsets.init(top: 20, left: 0, bottom: 10, right: 0)
		default:
			return UIEdgeInsets.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		guard let model = collectionView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTLiveContentModel else {
			return
		}
		let detailController = HTLiveDetailController()
		detailController.roomIdString = model.rid
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}

}

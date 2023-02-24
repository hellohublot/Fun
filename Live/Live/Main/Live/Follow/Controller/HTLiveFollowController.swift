//
//  HTLiveFollowController.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTLiveFollowController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.placeholderProvider = Placeholder.default
		collectionView.register(HTLiveFollowSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTLiveFollowSectionHeaderView.identifier)
        collectionView.register(HTLiveFollowSectionPlaceholderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HTLiveFollowSectionPlaceholderView.identifier)
		return collectionView
	}()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFollowModelArray), name: HTUserAuthManager.authStateNotification, object: nil)
		collectionView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.followList({ (result) in
				guard let value = result.value as? [String: Any] else {
					self?.collectionView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTLiveFollowSectionModel.packModelArray(value)
				self?.collectionView.setSectionModelArray(modelArray, proxy: self)
				self?.collectionView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
				self?.collectionView.reloadData()
			})
		}
        reloadFollowModelArray()
	}

	func initInterface() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: 0, right: 0))
		}
	}
    
    @objc func reloadFollowModelArray() {
        collectionView.respondHeaderRefresh()
    }

	/*-------------------------------------/ controller override /-----------------------------------*/



}


extension HTLiveFollowController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveFollowSectionModel
		switch sectionModel?.type {
		case .follow?:
			return HTLiveContentCell.self
		case .recommend?:
			return HTLiveFollowRecommendCell.self
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
        let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveFollowSectionModel
        var reuseClass: ReuseCell.Type
        switch kind {
        case UICollectionElementKindSectionHeader:
            reuseClass = HTLiveFollowSectionHeaderView.self
        case UICollectionElementKindSectionFooter:
            reuseClass = HTLiveFollowSectionPlaceholderView.self
        default:
            reuseClass = HTLiveFollowSectionHeaderView.self
        }
		let reuseView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(reuseView as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return reuseView
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveFollowSectionModel
        switch sectionModel?.type {
        case .follow?:
            if (sectionModel?.modelArray.count ?? 0) <= 0, HTUserAuthManager.isLogin() == false {
                return CGSize.zero
            }
            return CGSize.init(width: collectionView.bounds.size.width, height: 60)
        case .recommend?:
            return CGSize.init(width: collectionView.bounds.size.width, height: 60)
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
        let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTLiveFollowSectionModel
        switch sectionModel?.type {
        case .follow?:
            return CGSize.init(width: itemWidthFromItemSingleColumnCount(2, indexPath.section), height: 200)
        case .recommend?:
            return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 110)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveFollowSectionModel
        switch sectionModel?.type {
        case .follow?:
            if (sectionModel?.modelArray.count ?? 0) <= 0 {
                return CGSize.init(width: collectionView.bounds.size.width, height: 230)
            }
            return CGSize.zero
        default:
            return CGSize.zero
        }
    }
    
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveFollowSectionModel
		switch sectionModel?.type {
		case .follow?:
			return 10
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveFollowSectionModel
		switch sectionModel?.type {
		case .follow?:
			return 10
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTLiveFollowSectionModel
		switch sectionModel?.type {
		case .follow?:
            return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
		default:
			return UIEdgeInsets.zero
		}
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

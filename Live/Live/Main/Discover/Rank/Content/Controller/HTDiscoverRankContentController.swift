//
//  HTDiscoverRankContentController.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftPlaceholder

class HTDiscoverRankContentController: UIViewController {

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
	
	func reloadContentModelArrayWithPageModel(_ pageModel: HTDiscoverRankPageModel?) {
		collectionView.placeholderState = .firstRefresh
		Request.list.rankList(pageModel?.type) { [weak self] (result) in
			guard let value = result.value as? [String: Any] else {
				self?.collectionView.placeholderState = .errorNetwork
				return
			}
			let sectionModelArray = HTDiscoverRankContentSectionModel.packModelArray(pageModel, value)
			self?.collectionView.placeholderState = sectionModelArray.count > 0 ? .none : .nothingDisplay
			self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
			self?.collectionView.reloadData()
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTDiscoverRankContentController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverRankContentSectionModel
		switch sectionModel?.type {
		case .header?:
			return HTDiscoverRankContentHeaderCell.self
		case .normal?:
			return HTDiscoverRankContentNormalCell.self
		default:
			return HTDiscoverRankContentNormalCell.self
		}
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverRankContentSectionModel
		switch sectionModel?.type {
		case .header?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(3, indexPath.section), height: 210)
		case .normal?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 75)
		default:
			return CGSize.zero
		}
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = collectionView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTDiscoverRankContentModel
        if (model?.rid.count ?? 0) > 0 {
            let liveController = HTLiveDetailController()
            liveController.roomIdString = model?.rid
            liveController.modalPresentationStyle = .fullScreen
            Appdelegate.rootController()?.present(liveController, animated: false, completion: nil)
        } else {
            let userController = HTMineUserController()
            userController.uidString = "\(model?.uid)"
            userController.modalPresentationStyle = .fullScreen
            Appdelegate.navigationController()?.pushViewController(userController, animated: true)
        }
    }
	
}

//
//  HTMineStoreVIPController.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTCollectionFallLayout

class HTMineStoreVIPController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let fallLayout = HTCollectionFallLayout.init()
		fallLayout.delegate = self
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: fallLayout)
		collectionView.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
		collectionView.register(HTMineStoreVIPRechargeFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HTMineStoreVIPRechargeFooterView.identifier)
		collectionView.register(HTMineStoreVIPDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTMineStoreVIPDetailHeaderView.identifier)
		collectionView.register(HTMineStoreVIPDetailFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HTMineStoreVIPDetailFooterView.identifier)
		fallLayout.register(HTMineStoreVIPRechargeBackgroundView.self, forDecorationViewOfKind: HTMineStoreVIPRechargeBackgroundView.identifier)
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		let modelArray = HTMineStoreVIPSectionModel.packModelArray()
		collectionView.setSectionModelArray(modelArray, proxy: self)
	}
	
	func initInterface() {
		view.addSubview(collectionView)
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTMineStoreVIPController: CollectionViewThrough, HTCollectionFallDelegateLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .banner?:
			return HTMineStoreVIPBannerCell.self
		case .recharge?:
			return HTMineStoreVIPRechargeCell.self
		case .detail?:
			return HTMineStoreVIPDetailCell.self
		default:
			return HTMineStoreVIPRechargeCell.self
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreVIPSectionModel
		var reuseClass: ReuseCell.Type
		switch kind {
		case UICollectionElementKindSectionHeader:
			switch sectionModel?.type {
			case .detail?:
				reuseClass = HTMineStoreVIPDetailHeaderView.self
			default:
				reuseClass = HTMineStoreVIPDetailHeaderView.self
			}
		case UICollectionElementKindSectionFooter:
			switch sectionModel?.type {
			case .recharge?:
				reuseClass = HTMineStoreVIPRechargeFooterView.self
			case .detail?:
				reuseClass = HTMineStoreVIPDetailFooterView.self
			default:
				reuseClass = HTMineStoreVIPRechargeFooterView.self
			}
		default:
			reuseClass = HTMineStoreVIPDetailHeaderView.self
		}
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseClass.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .detail?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 22)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSectionAt section: Int) -> Int {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .banner?:
			return 1
		case .recharge?:
			return 2
		case .detail?:
			return 3
		default:
			return 1
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .banner?:
			return 250
		case .recharge?:
			return 90
		case .detail?:
			return 120
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .recharge?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 120)
		case .detail?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 35)
		default:
			return CGSize.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, lineSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .recharge?:
			return 15
		case .detail?:
			return 1 / UIScreen.main.scale
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, interitemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .recharge?:
			return 15
		case .detail?:
			return 1 / UIScreen.main.scale
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		switch sectionModel?.type {
		case .recharge?:
			return UIEdgeInsets.init(top: 18, left: 18, bottom: 18, right: 18)
		default:
			return UIEdgeInsets.zero
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, layoutAttributesForDecorationViewInSection section: Int, sectionContentMinY minY: CGFloat, sectionContentMaxY maxY: CGFloat) -> UICollectionViewLayoutAttributes? {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineStoreVIPSectionModel
		if case .detail? = sectionModel?.type {
			return nil
		}
		let attributed = HTCollectionViewLayoutAttributes.init(forDecorationViewOfKind: HTMineStoreVIPRechargeBackgroundView.identifier, with: IndexPath.init(row: 0, section: section))
		attributed.frame = CGRect.init(x: 0, y: minY, width: collectionView.bounds.size.width, height: maxY - minY)
		attributed.zIndex = -2
		attributed.model = sectionModel as Any
		return attributed
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
	
}

//
//  HTSetupNotifyController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTCollectionFallLayout

class HTSetupNotifyController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let fallLayout = HTCollectionFallLayout.init()
		fallLayout.delegate = self
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: fallLayout)
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = UIColor.clear
		collectionView.allowsSelection = false
		fallLayout.register(HTSetupNotifySectionBackgroundView.self, forDecorationViewOfKind: HTSetupNotifySectionBackgroundView.identifier)
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		let modelArray = HTSetupNotifySectionModel.packModelArray()
		collectionView.setSectionModelArray(modelArray, proxy: self)
	}
	
	func initInterface() {
		navigationItem.title = "通知管理"
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTSetupNotifyController: CollectionViewThrough, HTCollectionFallDelegateLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTSetupNotifySectionModel
		switch sectionModel?.type {
		case .title?:
			return HTSetupNotifyTitleCell.self
		default:
			return HTSetupNotifySwitchCell.self
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSectionAt section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTSetupNotifySectionModel
		switch sectionModel?.type {
		case .title?:
			return 40
		default:
			return 44
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTSetupNotifySectionModel
		switch sectionModel?.type {
		case .title?:
			return UIEdgeInsets.zero
		default:
			return UIEdgeInsets.init(top: 15, left: 0, bottom: 0, right: 0)			
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, layoutAttributesForDecorationViewInSection section: Int, sectionContentMinY minY: CGFloat, sectionContentMaxY maxY: CGFloat) -> UICollectionViewLayoutAttributes? {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTSetupNotifySectionModel
		if case .title? = sectionModel?.type {
			return nil
		}
		let attributed = HTCollectionViewLayoutAttributes.init(forDecorationViewOfKind: HTSetupNotifySectionBackgroundView.identifier, with: IndexPath.init(row: 0, section: section))
		let headerHeight = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section).top
		attributed.frame = CGRect.init(x: 0, y: minY + headerHeight, width: collectionView.bounds.size.width, height: maxY - minY - headerHeight)
		attributed.zIndex = -1
		attributed.model = sectionModel as Any
		return attributed
	}
	
}


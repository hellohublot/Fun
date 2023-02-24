//
//  HTMineController.swift
//  Live
//
//  Created by hublot on 2018/12/25.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTCollectionFallLayout

class HTMineController: UIViewController, HTControllerSecondReload {

	lazy var collectionView: UICollectionView = {
		let fallLayout = HTCollectionFallLayout.init()
		fallLayout.delegate = self
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: fallLayout)
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = UIColor.init(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
		fallLayout.register(HTMineSectionBackgroundView.self, forDecorationViewOfKind: HTMineSectionBackgroundView.identifier)
		return collectionView
	}()
	
	lazy var backgroundView: HTMineBackgroundView = {
		let backgroundView = HTMineBackgroundView.init(frame: CGRect.zero)
		return backgroundView
	}()
	
	lazy var navigationBar: HTMineNavigationBar = {
		let navigationBar = HTMineNavigationBar.init(frame: CGRect.zero)
		return navigationBar
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		NotificationCenter.default.addObserver(self, selector: #selector(reloadUserInfoModelArray), name: HTUserAuthManager.authStateNotification, object: nil)
		reloadUserInfoModelArray()
	}

	@objc func reloadUserInfoModelArray() {
		Request.list.userInfo { [weak self] (result) in
			let value = result.value as? [String: Any] ?? [String: Any]()
			HTUserAuthManager.userInfo = value
			let modelArray = HTMineSectionModel.packModelArray(value)
			self?.collectionView.setSectionModelArray(modelArray, proxy: self)
			self?.collectionView.reloadData()
		}
	}
	
	func initInterface() {
		navigationController?.navigationBar.isHidden = true
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(collectionView)
		view.addSubview(navigationBar)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		collectionView.contentInset = UIEdgeInsets.init(top: HTStatic.navigationHeight + 10, left: 0, bottom: 0, right: 0)
		collectionView.backgroundView = backgroundView
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if secondReload() {
			reloadUserInfoModelArray()
		}
	}
	

}

extension HTMineController: CollectionViewThrough, HTCollectionFallDelegateLayout {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentOffset = -offsetY - collectionView.contentInset.top
		navigationBar.reloadCollectionContentOffset(contentOffset)
		backgroundView.reloadCollectionContentOffset(contentOffset)
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineSectionModel
		switch sectionModel?.type {
		case .user?:
			return HTMineUserCell.self
		case .record?:
			return HTMineRecordCell.self
		default:
			return HTMineActionCell.self
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.zero
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSectionAt section: Int) -> Int {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineSectionModel
		switch sectionModel?.type {
		case .record?:
			return sectionModel?.modelArray.count ?? 1
		default:
			return 1
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineSectionModel
		switch sectionModel?.type {
		case .user?:
			return 116
		case .record?:
			return 85
		default:
			return 50
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize.zero
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, lineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, interitemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineSectionModel
		switch sectionModel?.type {
		case .record?:
			return UIEdgeInsets.init(top: 0, left: 12, bottom: 10, right: 12)
		default:
			return UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, layoutAttributesForDecorationViewInSection section: Int, sectionContentMinY minY: CGFloat, sectionContentMaxY maxY: CGFloat) -> UICollectionViewLayoutAttributes? {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTMineSectionModel
		let attributed = HTCollectionViewLayoutAttributes.init(forDecorationViewOfKind: HTMineSectionBackgroundView.identifier, with: IndexPath.init(row: 0, section: section))
		let footerHeight = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section).bottom
		attributed.frame = CGRect.init(x: 0, y: minY, width: collectionView.bounds.size.width, height: maxY - minY - footerHeight)
		attributed.zIndex = -1
		attributed.model = sectionModel as Any
		return attributed
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTMineSectionModel
		var willController: UIViewController?
		switch sectionModel?.type {
		case .user?:
			if HTUserAuthManager.isLogin() == false {
				HTUserAuthManager.showLoginController()
				return
			}
		default:
			let model = sectionModel?.modelArray[indexPath.row] as? HTMineActionModel
			if case .service? = model?.type {} else {
				if HTUserAuthManager.isLogin() == false {
					HTUserAuthManager.showLoginController()
					return
				}
			}
			switch model?.type {
			case .message?:
				willController = HTMineMessageController()
			case .task?:
				let webController = HTWebController()
				webController.initalizeUrl = Request.url("https://www.9xiu.com/mobileapp/mobile_task?openSource=1")
				willController = webController
			case .store?:
				willController = HTMineStoreController()
			case .sign?:
				HTMineSignController.showUserSignView()
			case .recharge?:
				willController = HTMineRechargeController()
			case .tool?:
				willController = HTMineToolController()
			case .love?:
				willController = HTMineLoveController()
			case .policy?:
				willController = HTMineGuardController()
			case .video?:
				willController = HTMineVideoController()
			case .badge?:
				willController = HTMineBadgeController()
			case .service?:
				willController = HTMineServiceController()
			default:
				break
			}
		}
		if let willController = willController {
			navigationController?.pushViewController(willController, animated: true)
		}
	}
	
}

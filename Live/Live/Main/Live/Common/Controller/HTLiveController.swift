//
//  HTLiveController.swift
//  Live
//
//  Created by hublot on 2018/12/25.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTLiveController: UIViewController {

	var pageModelArray = HTLivePageModel.packModelArray()
	
	lazy var navigationBar: HTLiveNavigationBar = {
		let navigationBar = HTLiveNavigationBar.init(frame: CGRect.zero)
		navigationBar.pageHeaderView.pageDelegate = self
		return navigationBar
	}()
	
	lazy var flyLoginView: HTLiveFlyLoginView = {
		let flyLoginView = HTLiveFlyLoginView.init(frame: CGRect.zero)
		return flyLoginView
	}()
	
	lazy var pageContentView: HTPageContentView = {
		let pageContentView = HTPageContentView.init(frame: CGRect.zero)
		pageContentView.pageDelegate = self
		return pageContentView
	}()
	
	var lastSelectedIndex = -1
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		NotificationCenter.default.addObserver(self, selector: #selector(locationManagerDidChange), name: HTLiveNearLocationManager.locationNotification, object: nil)
	}
	
	func initInterface() {
		navigationController?.navigationBar.isHidden = true
		view.addSubview(pageContentView)
		view.addSubview(navigationBar)
		view.addSubview(flyLoginView)
		automaticallyAdjustsScrollViewInsets = false
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		pageContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		flyLoginView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-15)
			maker.left.equalTo(0)
		}
		navigationBar.pageHeaderView.collectionView.setCellModelArray(pageModelArray, proxy: navigationBar.pageHeaderView)
		pageContentView.collectionView.setCellModelArray(pageModelArray, proxy: pageContentView)
		
		view.layoutIfNeeded()
		navigationBar.pageHeaderView.collectionView.reloadData()
		pageContentView.collectionView.reloadData()

		navigationBar.pageHeaderView.collectionView(navigationBar.pageHeaderView.collectionView, didSelectItemAt: IndexPath.init(row: 1, section: 0))
//		pageContentView.scrollViewDidScroll(pageContentView.collectionView)
	}

	@objc func locationManagerDidChange() {
		guard let currentCityModel = HTLiveNearCityModel.packCurrentCityModel(true) else {
			return
		}
		for pageModel in pageModelArray {
			if case .near? = pageModel.type {
				pageModel.title = currentCityModel.title
			}
		}
		navigationBar.pageHeaderView.collectionView.setCellModelArray(pageModelArray, proxy: navigationBar.pageHeaderView)
		navigationBar.pageHeaderView.collectionView.reloadData()
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		flyLoginView.isHidden = HTUserAuthManager.isLogin()
	}

}


extension HTLiveController: HTPageHeaderViewDelegate, HTPageContentControllerDelegate {
	
	func reloadNavigationSelecetd(_ indexPath: IndexPath) {
		var modelArray = navigationBar.pageHeaderView.collectionView.cellModelArray() as? [HTPageModelAble] ?? [HTPageModelAble]()
		for var model in modelArray {
			model.selected = false
		}
		modelArray[indexPath.row].selected = true
		navigationBar.pageHeaderView.collectionView.reloadData()
		navigationBar.pageHeaderView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView == pageContentView.collectionView else {
			return
		}
		
		let offsetX = scrollView.contentOffset.x
		let progress = offsetX / scrollView.bounds.size.width
		
		let selectedIndex = Int(round(progress))
		if selectedIndex != lastSelectedIndex {
			reloadNavigationSelecetd(IndexPath.init(row: selectedIndex, section: 0))
		}
		lastSelectedIndex = selectedIndex
		
		let translationX = scrollView.panGestureRecognizer.translation(in: scrollView).x
		let fromIndex = Int(translationX <= 0 ? floor(progress) : ceil(progress))
		let toIndex = Int(translationX > 0 ? floor(progress) : ceil(progress))
		guard var fromFrame = navigationBar.pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: fromIndex, section: 0))?.frame else {
			return
		}
		guard var toFrame = navigationBar.pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: toIndex, section: 0))?.frame else {
			return
		}
		
		
		fromFrame.origin.x += fromFrame.size.width * 0.22
		fromFrame.size.width *= 0.56
		toFrame.origin.x += toFrame.size.width * 0.22
		toFrame.size.width *= 0.56
		
		var separatorLineFrame = CGRect.init(x: 0, y: navigationBar.pageHeaderView.collectionView.bounds.size.height - 9, width: 0, height: 3)
		navigationBar.pageHeaderView.pageLineLayer.cornerRadius = 3 / 2.0
		navigationBar.pageHeaderView.collectionView.layer.insertSublayer(navigationBar.pageHeaderView.pageLineLayer, at: 0)
		
		if fromIndex <= toIndex {
			if progress - CGFloat(fromIndex) <= 0.5 {
				separatorLineFrame.origin.x = fromFrame.minX
				separatorLineFrame.size.width = fromFrame.width + (toFrame.maxX - fromFrame.maxX) * 2 * (progress - CGFloat(fromIndex))
			} else {
				separatorLineFrame.size.width = toFrame.width + (toFrame.minX - fromFrame.minX) * 2 * (CGFloat(toIndex) - progress)
				separatorLineFrame.origin.x = toFrame.maxX - separatorLineFrame.size.width
			}
		} else {
			if CGFloat(fromIndex) - progress <= 0.5 {
				separatorLineFrame.size.width = fromFrame.width + (fromFrame.minX - toFrame.minX) * 2 * (CGFloat(fromIndex) - progress)
				separatorLineFrame.origin.x = fromFrame.maxX - separatorLineFrame.size.width
			} else {
				separatorLineFrame.origin.x = toFrame.minX
				separatorLineFrame.size.width = toFrame.width + (fromFrame.maxX - toFrame.maxX) * 2 * (progress - CGFloat(toIndex))
			}
		}
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		navigationBar.pageHeaderView.pageLineLayer.frame = separatorLineFrame
		CATransaction.commit()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: false)
		pageContentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		reloadNavigationSelecetd(indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let model = pageModelArray[indexPath.row]
		let width = model.title?.width(HTPageHeaderCell.titleFont, collectionView.bounds.size.height) ?? 0
		return CGSize.init(width: width + 15, height: collectionView.bounds.size.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
	}
	
	func pageContentViewModelWillAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		
	}
	
	func pageContentViewModelDidAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		guard let model = model as? HTLivePageModel else {
			return
		}
		if let controller = model.controller as? HTLiveContentController {
			controller.reloadModelArrayWithType(model.type)
		}
	}
	
}

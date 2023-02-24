//
//  HTVideoController.swift
//  Live
//
//  Created by hublot on 2018/12/25.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTVideoController: UIViewController, HTVideoRefreshProtocol {

	let pageModelArray = HTVideoPageModel.packModelArray()
	
	var visibleModel: HTPageModelAble?

	lazy var navigationBar: HTVideoNavigationBar = {
		let navigationBar = HTVideoNavigationBar.init(frame: CGRect.zero)
		navigationBar.pageHeaderView.pageDelegate = self
		return navigationBar
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
		
	}

	func initInterface() {
		navigationController?.navigationBar.isHidden = true
		view.addSubview(pageContentView)
		view.addSubview(navigationBar)
		automaticallyAdjustsScrollViewInsets = false
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		pageContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		navigationBar.pageHeaderView.collectionView.setCellModelArray(pageModelArray, proxy: navigationBar.pageHeaderView)
		pageContentView.collectionView.setCellModelArray(pageModelArray, proxy: pageContentView)

		view.layoutIfNeeded()
		navigationBar.pageHeaderView.collectionView.reloadData()
		pageContentView.collectionView.reloadData()

		pageContentView.collectionView.isScrollEnabled = false
		for (index, model) in pageModelArray.enumerated() {
			if model.selected == true {
				collectionView(navigationBar.pageHeaderView.collectionView, didSelectItemAt: IndexPath.init(row: index, section: 0))
				continue
			}
		}

	}
	
	func setRefresh(_ refresh: Bool, animated: Bool) {
		navigationBar.refreshView.setRefresh(refresh, animated: animated)
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		visibleModel?.controller?.viewDidAppear(animated)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		visibleModel?.controller?.viewDidDisappear(animated)
	}

}


extension HTVideoController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HTPageContentControllerDelegate {

	func reloadNavigationSelecetd(_ indexPath: IndexPath) {
		var modelArray = navigationBar.pageHeaderView.collectionView.cellModelArray() as? [HTPageModelAble] ?? [HTPageModelAble]()
		for var model in modelArray {
			model.selected = false
		}
		modelArray[indexPath.row].selected = true
		navigationBar.pageHeaderView.collectionView.reloadData()
		
		
		visibleModel?.controller?.viewDidDisappear(true)
		visibleModel = modelArray[indexPath.row]
		visibleModel?.controller?.viewDidAppear(true)
		
		guard let cellFrame = navigationBar.pageHeaderView.collectionView.layoutAttributesForItem(at: indexPath)?.frame else {
			return
		}
		var separatorLineFrame = CGRect.init(x: 0, y: navigationBar.pageHeaderView.collectionView.bounds.size.height - 5, width: 20, height: 3)
		separatorLineFrame.origin.x = cellFrame.origin.x + (cellFrame.size.width - separatorLineFrame.size.width) / 2.0
		navigationBar.pageHeaderView.pageLineLayer.cornerRadius = 3 / 2.0
		navigationBar.pageHeaderView.collectionView.layer.insertSublayer(navigationBar.pageHeaderView.pageLineLayer, at: 0)
		
		CATransaction.begin()
		CATransaction.setAnimationDuration(0.25)
		navigationBar.pageHeaderView.pageLineLayer.frame = separatorLineFrame
		CATransaction.commit()
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: false)
		pageContentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		reloadNavigationSelecetd(indexPath)
	}
	
	func pageContentViewModelWillAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		(model?.controller as? HTVideoRefreshController)?.delegate = self
	}

	func pageContentViewModelDidAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		
	}

}


//
//  HTMineMessageController.swift
//  Live
//
//  Created by hublot on 2019/1/9.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineMessageController: UIViewController {

	let pageModelArray = HTMineMessagePageModel.packModelArray()
		
	lazy var navigationBar: HTMineMessageNavigationBar = {
		let navigationBar = HTMineMessageNavigationBar.init(frame: CGRect.zero)
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
		
		pageContentView.scrollViewDidScroll(pageContentView.collectionView)

	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTMineMessageController: HTPageHeaderViewDelegate, HTPageContentControllerDelegate {
	
	func reloadNavigationSelecetd(_ indexPath: IndexPath) {
		var modelArray = navigationBar.pageHeaderView.collectionView.cellModelArray() as? [HTPageModelAble] ?? [HTPageModelAble]()
		for var model in modelArray {
			model.selected = false
		}
		let selectedModel = modelArray[indexPath.row] as? HTMineMessagePageModel
		switch selectedModel?.type {
		case .message?:
			navigationBar.ignoreButton.isSelected = false
		case .friend?:
			navigationBar.ignoreButton.isSelected = true
		default:
			break
		}
		selectedModel?.selected = true
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
		guard let fromFrame = navigationBar.pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: fromIndex, section: 0))?.frame else {
			return
		}
		guard let toFrame = navigationBar.pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: toIndex, section: 0))?.frame else {
			return
		}
		
		var separatorLineFrame = CGRect.init(x: 0, y: navigationBar.pageHeaderView.collectionView.bounds.size.height - 9, width: 0, height: 3)
		navigationBar.pageHeaderView.pageLineLayer.cornerRadius = 3 / 2.0
		navigationBar.pageHeaderView.collectionView.layer.insertSublayer(navigationBar.pageHeaderView.pageLineLayer, at: 0)
		
		let scale = fromIndex == toIndex ? 0 : 1 - 2 * abs(CGFloat(fromIndex + toIndex) / 2.0 - progress)
		if fromIndex <= toIndex {
			let width = fromFrame.width + (toFrame.width - fromFrame.width) * (progress - CGFloat(fromIndex))
			let centerX = fromFrame.midX + (toFrame.midX - fromFrame.midX) * (progress - CGFloat(fromIndex))
			separatorLineFrame.size.width = width * 0.2 + 40 * scale
			separatorLineFrame.origin.x = centerX - separatorLineFrame.size.width / 2.0
		} else {
			let width = fromFrame.width + (toFrame.width - fromFrame.width) * (CGFloat(fromIndex) - progress)
			let centerX = toFrame.midX + (fromFrame.midX - toFrame.midX) * (progress - CGFloat(toIndex))
			separatorLineFrame.size.width = width * 0.2 + 40 * scale
			separatorLineFrame.origin.x = centerX - separatorLineFrame.size.width / 2.0
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
		let contentInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: 0)
		let width = (collectionView.bounds.size.width - contentInset.left - contentInset.right) / CGFloat(collectionView.cellModelArray().count)
		return CGSize.init(width: width, height: collectionView.bounds.size.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 120, bottom: 0, right: 120)
	}
	
	func pageContentViewModelWillAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		
	}
	
	func pageContentViewModelDidAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
		
	}
	
}


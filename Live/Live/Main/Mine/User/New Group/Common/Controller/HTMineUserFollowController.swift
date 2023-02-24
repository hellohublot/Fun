//
//  HTMineUserFollowController.swift
//  Live
//
//  Created by hublot on 2019/1/22.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineUserFollowController: UIViewController {
	
	var uidString = ""

	lazy var pageModelArray: [HTMineUserFollowPageModel] = {
		let pageModelArray = HTMineUserFollowPageModel.packModelArray(uidString)
		return pageModelArray
	}()
	
	lazy var navigationBar: HTMineUserFollowNavigationBar = {
		let navigationBar = HTMineUserFollowNavigationBar.init(frame: CGRect.zero)
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
		navigationBar.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.left.right.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight + 44)
		}
		pageContentView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(navigationBar.snp.bottom)
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

extension HTMineUserFollowController: HTPageHeaderViewDelegate, HTPageContentControllerDelegate {
	
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
		
		
		fromFrame.origin.x += fromFrame.size.width * 0.38
		fromFrame.size.width *= 0.24
		toFrame.origin.x += toFrame.size.width * 0.38
		toFrame.size.width *= 0.24
		
		var separatorLineFrame = CGRect.init(x: 0, y: navigationBar.pageHeaderView.collectionView.bounds.size.height - 7, width: 0, height: 3)
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
	
	func pageHeaderViewCellSetModel(_ pageHeaderView: HTPageHeaderView, _ pageHeaderCell: HTPageHeaderCell, _ pageIndex: Int, _ model: HTPageModelAble?) {
		pageHeaderCell.titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let contentInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: 0)
		let width = (collectionView.bounds.size.width - contentInset.left - contentInset.right) / CGFloat(collectionView.cellModelArray().count)
		return CGSize.init(width: width, height: collectionView.bounds.size.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
	func pageContentViewModelWillAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
        
	}
	
	func pageContentViewModelDidAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {
        model?.controller?.viewDidAppear(true)
	}
	
}



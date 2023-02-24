//
//  HTMineUserPageController.swift
//  Live
//
//  Created by hublot on 2019/1/17.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineUserPageManager: NSObject {

	var pageModelArray = [HTMineUserPageModel]()
	
	var currentPageController: HTMineUserContentControllerAble?

	var currentPageHeight: CGFloat = 0
	
	weak var superController: HTMineUserController?

	lazy var pageHeaderView: HTPageHeaderView = {
		let pageHeaderView = HTPageHeaderView.init(frame: CGRect.zero)
		pageHeaderView.pageDelegate = self
		return pageHeaderView
	}()

	lazy var pageContentView: HTPageContentView = {
		let pageContentView = HTPageContentView.init(frame: CGRect.zero)
		pageContentView.pageDelegate = self
		return pageContentView
	}()

	var lastSelectedIndex = -1

	/*-------------------------------------/ init /-----------------------------------*/

	init(_ uidString: String?, _ superController: HTMineUserController?) {
		super.init()
		pageModelArray = HTMineUserPageModel.packModelArray(uidString)
		self.superController = superController
		pageHeaderView.collectionView.setCellModelArray(pageModelArray, proxy: pageHeaderView)
		pageContentView.collectionView.setCellModelArray(pageModelArray, proxy: pageContentView)

		pageHeaderView.collectionView.reloadData()
		pageContentView.collectionView.reloadData()
	}

}

extension HTMineUserPageManager: HTPageHeaderViewDelegate, HTPageContentControllerDelegate {

	func reloadNavigationSelecetd(_ indexPath: IndexPath) {
		var modelArray = pageHeaderView.collectionView.cellModelArray() as? [HTPageModelAble] ?? [HTPageModelAble]()
		for var model in modelArray {
			model.selected = false
			(model.controller as? HTMineUserContentControllerAble)?.reloadSuperControllerHeightBlock = nil
		}
		var selectedModel = modelArray[indexPath.row]
		selectedModel.selected = true
		pageHeaderView.collectionView.reloadData()
		pageHeaderView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

		let selectedController = selectedModel.controller as? HTMineUserContentControllerAble
		currentPageController = selectedController
		selectedController?.reloadSuperControllerHeightBlock = { [weak self] (height) in
			guard height != self?.currentPageHeight else {
				return
			}
			self?.currentPageHeight = height
			self?.superController?.reloadTableViewContentView()
		}
		selectedController?.requestModelArray(true)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView == pageContentView.collectionView else {
			return
		}

		let offsetX = scrollView.contentOffset.x
		let progress = offsetX / scrollView.bounds.size.width

		let translationX = scrollView.panGestureRecognizer.translation(in: scrollView).x
		let fromIndex = Int(translationX <= 0 ? floor(progress) : ceil(progress))
		let toIndex = Int(translationX > 0 ? floor(progress) : ceil(progress))
		guard var fromFrame = pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: fromIndex, section: 0))?.frame else {
			return
		}
		guard var toFrame = pageHeaderView.collectionView.layoutAttributesForItem(at: IndexPath.init(row: toIndex, section: 0))?.frame else {
			return
		}


		fromFrame.origin.x += fromFrame.size.width * 0.3
		fromFrame.size.width *= 0.40
		toFrame.origin.x += toFrame.size.width * 0.3
		toFrame.size.width *= 0.40

		var separatorLineFrame = CGRect.init(x: 0, y: pageHeaderView.collectionView.bounds.size.height - 7, width: 0, height: 3)
		pageHeaderView.pageLineLayer.cornerRadius = 3 / 2.0
		pageHeaderView.collectionView.layer.insertSublayer(pageHeaderView.pageLineLayer, at: 0)

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
		pageHeaderView.pageLineLayer.frame = separatorLineFrame
		CATransaction.commit()
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if decelerate == false {
			scrollViewDidEndDecelerating(scrollView)
		}
	}

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

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

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: false)
		pageContentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		reloadNavigationSelecetd(indexPath)
	}

	func pageHeaderViewCellSetModel(_ pageHeaderView: HTPageHeaderView, _ pageHeaderCell: HTPageHeaderCell, _ pageIndex: Int, _ model: HTPageModelAble?) {
		pageHeaderCell.titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
	}

	func itemWidthFromItemSingleColumnCount(_ count: Int, _ section: Int) -> CGFloat {
		var width = pageHeaderView.collectionView.frame.size.width
		let sectionInset = collectionView(pageHeaderView.collectionView, layout: pageHeaderView.collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumInteritemWidth = collectionView(pageHeaderView.collectionView, layout: pageHeaderView.collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
		width -= (sectionInset.left + sectionInset.right)
		width -= (CGFloat(count - 1) * minimumInteritemWidth)
		return floor(width / CGFloat(count))
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize.init(width: itemWidthFromItemSingleColumnCount(collectionView.cellModelArray().count, indexPath.section), height: collectionView.bounds.size.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 25
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 25
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
	}
	
	func responderFooterRefresh() {
		currentPageController?.requestModelArray(false)
	}

	func pageContentViewModelWillAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {

	}

	func pageContentViewModelDidAppear(_ pageContentView: HTPageContentView, _ pageIndex: Int, _ model: HTPageModelAble?) {

	}

}

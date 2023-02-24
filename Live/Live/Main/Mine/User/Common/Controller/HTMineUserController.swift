//
//  HTMineUserController.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftPlaceholder

class HTMineUserController: UIViewController {

	var uidString = ""
	
	lazy var navigationBar: HTMineUserNavigationBar = {
		let navigationBar = HTMineUserNavigationBar.init(frame: CGRect.zero)
		return navigationBar
	}()
	
	lazy var backgroundView: HTMineUserBackgroundView = {
		let backgroundView = HTMineUserBackgroundView.init(frame: CGRect.zero)
		return backgroundView
	}()
	
	lazy var tabBar: HTMineUserTabBar = {
		let tabBar = HTMineUserTabBar.init(frame: CGRect.zero)
		return tabBar
	}()

	lazy var pageManager: HTMineUserPageManager = {
		let pageManager = HTMineUserPageManager.init(uidString, self)
		return pageManager
	}()

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.estimatedRowHeight = 0
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		tableView.placeholderProvider = Placeholder.default
		tableView.register(HTMineUserPageHeaderView.self, forHeaderFooterViewReuseIdentifier: HTMineUserPageHeaderView.identifier)
		return tableView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		pageManager.pageModelArray = HTMineUserPageModel.packModelArray(uidString)
		tableView.placeholderState = .firstRefresh
		Request.list.userDetail(uidString) { [weak self] (result) in
			guard let value = result.value as? [String: Any], let userModel = HTMineUserInfoModel.mj_object(withKeyValues: value) else {
				self?.tableView.placeholderState = .errorNetwork
				return
			}

			self?.backgroundView.setModel(userModel)

			let modelArray = HTMineUserSectionModel.packModelArray(userModel)
			self?.tableView.setSectionModelArray(modelArray, proxy: self)
			self?.tableView.placeholderState = .none
			self?.reloadTableViewContentView()
		}
	}

	func reloadTableViewContentView() {
		tableView.reloadData()
		tableView.layoutIfNeeded()
		pageManager.scrollViewDidEndDecelerating(pageManager.pageContentView.collectionView)
		pageManager.scrollViewDidScroll(pageManager.pageContentView.collectionView)
	}
	
	func initInterface() {
		navigationController?.navigationBar.isHidden = true
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(backgroundView)
		view.addSubview(tableView)
		view.addSubview(tabBar)
		view.addSubview(navigationBar)
		backgroundView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		tableView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(navigationBar.snp.bottom)
		}
		tabBar.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(70)
		}
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.top.right.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		view.layoutIfNeeded()
		scrollViewDidScroll(tableView)
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: true)
	}
	

}

extension HTMineUserController: TableViewThrough {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentOffset = -offsetY - scrollView.contentInset.top
		backgroundView.reloadTableViewContentOffset(contentOffset)
		if scrollView.contentSize.height > 0, scrollView.contentSize.height + contentOffset - scrollView.bounds.size.height <= 100 {
			pageManager.responderFooterRefresh()
		}
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = tableView.sectionModelArray()[indexPath.section] as? HTMineUserSectionModel
		switch sectionModel?.type {
		case .header?:
			return HTMineUserHeaderCell.self
		case .page?:
			return HTMineUserPageContentView.self
		default:
			return HTMineUserPageContentView.self
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTMineUserSectionModel
		switch sectionModel?.type {
		case .page?:
			let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTMineUserPageHeaderView.identifier)
			if let headerView = cell as? HTMineUserPageHeaderView {
				headerView.addSubview(pageManager.pageHeaderView)
				pageManager.pageHeaderView.snp.remakeConstraints { (maker) in
					maker.edges.equalTo(UIEdgeInsets.zero)
				}
				headerView.layoutIfNeeded()
			}
			(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
			return cell
		default:
			return nil
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let sectionModel = tableView.sectionModelArray()[section] as? HTMineUserSectionModel
		switch sectionModel?.type {
		case .page?:
			return HTMineUserPageHeaderView.pageHeaderHeight
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
		if let contentView = cell as? HTMineUserPageContentView {
			contentView.addSubview(pageManager.pageContentView)
			pageManager.pageContentView.snp.remakeConstraints { (maker) in
				maker.edges.equalTo(UIEdgeInsets.zero)
			}
			pageManager.pageContentView.collectionView.collectionViewLayout.invalidateLayout()
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let sectionModel = tableView.sectionModelArray()[indexPath.section] as? HTMineUserSectionModel
		switch sectionModel?.type {
		case .header?:
			return 230
		case .page?:
			let minHeight = tableView.bounds.size.height - HTMineUserPageHeaderView.pageHeaderHeight
			return max(minHeight, pageManager.currentPageHeight)
		default:
			return 0
		}
	}
	
}


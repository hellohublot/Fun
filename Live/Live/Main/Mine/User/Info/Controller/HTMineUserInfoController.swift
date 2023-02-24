//
//  HTMineUserInfoController.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineUserInfoController: UIViewController, HTMineUserContentControllerAble {

	var uidString = ""
	
	var reloadSuperControllerHeightBlock: ((CGFloat) -> Void)?
	
	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		tableView.estimatedRowHeight = 0.0001
		tableView.estimatedSectionHeaderHeight = 0.0001
		tableView.estimatedSectionFooterHeight = 0.0001
		tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 65))
		tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.0001))
		
		tableView.separatorStyle = .none
		tableView.backgroundColor = UIColor.clear
		tableView.isScrollEnabled = false
		tableView.allowsSelection = false
		tableView.placeholderProvider = Placeholder.default
		tableView.register(HTMineUserInfoTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: HTMineUserInfoTitleHeaderView.identifier)
		tableView.register(HTMineUserInfoLineHeaderView.self, forHeaderFooterViewReuseIdentifier: HTMineUserInfoLineHeaderView.identifier)
		return tableView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.userDetailInfoList(self?.uidString ?? "", { (result) in
				guard let value = result.value as? [String: Any] else {
					self?.tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTMineUserInfoSectionModel.packModelArray(value)
				self?.tableView.setSectionModelArray(modelArray, proxy: self)
				self?.tableView.reloadData()
				self?.tableView.layoutIfNeeded()
				self?.reloadSuperControllerHeightBlock?(self?.tableView.contentSize.height ?? 0)
				self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
			})
		}
	}
	
	func initInterface() {
		view.addSubview(tableView)
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	func requestModelArray(_ isHeaderRefresh: Bool) {
		if isHeaderRefresh {
			if tableView.cellModelArray().count <= 0 {
				tableView.respondHeaderRefresh()
			} else {
				reloadSuperControllerHeightBlock?(tableView.contentSize.height)
			}
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/


}

extension HTMineUserInfoController: TableViewThrough {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineUserInfoCell.self
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTMineUserInfoSectionModel
		var reuseClass: ReuseCell.Type
		switch sectionModel?.type {
		case .main?:
			reuseClass = HTMineUserInfoTitleHeaderView.self
		case .like?:
			reuseClass = HTMineUserInfoLineHeaderView.self
		default:
			reuseClass = HTMineUserInfoTitleHeaderView.self
		}
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseClass.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let sectionModel = tableView.sectionModelArray()[section] as? HTMineUserInfoSectionModel
		switch sectionModel?.type {
		case .main?:
			return 55
		case .like?:
			return 30
		default:
			return 0.0001
		}
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.0001
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
}

//
//  HTDiscoverActivityController.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverActivityController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.placeholderProvider = Placeholder.default
		return tableView
	}()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.activityList(pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any], let listValue = value["list"] else {
					self?.tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTDiscoverActivityModel.mj_objectArray(withKeyValuesArray: listValue) as? [HTDiscoverActivityModel] ?? [HTDiscoverActivityModel]()
				if pageIndex == 1 {
					self?.tableView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.tableView.cellModelArray() as? [HTDiscoverActivityModel] ?? [HTDiscoverActivityModel]()
					existModelArray += modelArray
					self?.tableView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.tableView.reloadData()
				self?.tableView.endRefreshWith(modelCount: modelArray.count)
			})
		}
		tableView.respondHeaderRefresh()
	}

	func initInterface() {
		navigationItem.title = "活动中心"
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}

extension HTDiscoverActivityController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTDiscoverActivityCell.self
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 210
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		let model = tableView.cellModelArray()[indexPath.row] as? HTDiscoverActivityModel
		let webController = HTWebController()
		webController.initalizeUrl = Request.url(model?.link)
		navigationController?.pushViewController(webController, animated: true)
	}

}

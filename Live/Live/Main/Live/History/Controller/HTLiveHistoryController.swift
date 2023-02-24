//
//  HTLiveHistoryController.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTLiveHistoryController: UIViewController {

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
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (_, _) in
			Request.list.historyList({ (result) in
				guard let value = result.value as? [Any] else {
					self?.tableView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTLiveHistoryModel.mj_objectArray(withKeyValuesArray: value) as? [HTLiveHistoryModel] ?? [HTLiveHistoryModel]()
				self?.tableView.setCellModelArray(modelArray, proxy: self)
				self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
				self?.tableView.reloadData()
			})
		}
		tableView.respondHeaderRefresh()
	}

	func initInterface() {
		navigationItem.title = "观看历史"
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension HTLiveHistoryController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveHistoryCell.self
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
		return 110
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let model = tableView.cellModelArray()[indexPath.row] as? HTLiveHistoryModel
		let detailController = HTLiveDetailController()
		detailController.roomIdString = String(model?.rid ?? 0)
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}

}

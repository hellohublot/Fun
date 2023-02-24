//
//  HTSetupBlackController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTSetupBlackController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.separatorColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.allowsSelection = false
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
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, pageCount) in
			Request.list.blackList(pageIndex - 1, { (result) in
				guard let value = result.value as? [Any] else {
					self?.tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTSetupBlackModel.mj_objectArray(withKeyValuesArray: value) as? [HTSetupBlackModel] ?? [HTSetupBlackModel]()
				if pageIndex == 1 {
					self?.tableView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.tableView.cellModelArray() as? [HTSetupBlackModel] ?? [HTSetupBlackModel]()
					existModelArray += modelArray
					self?.tableView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.tableView.endRefreshWith(modelCount: modelArray.count)
				self?.tableView.reloadData()
			})
		}
		tableView.respondHeaderRefresh()
	}
	
	func initInterface() {
		navigationItem.title = "黑名单"
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTSetupBlackController: TableViewThrough {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTSetupBlackCell.self
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
        let model = tableView.cellModelArray()[indexPath.row] as? HTSetupBlackModel
        (cell as? HTSetupBlackCell)?.removeButton.whenTouch(inside: { [weak self] (_, _) in
            Request.action.blackUserDelete(model?.uid ?? "", { (result) in
                guard let _ = result.value else {
                    return
                }
                self?.tableView.respondHeaderRefresh()
            })
        }, receive: nil)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
}

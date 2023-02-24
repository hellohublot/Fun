//
//  HTMineServiceController.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineServiceController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.backgroundColor = UIColor.clear
		tableView.placeholderProvider = Placeholder.default
		tableView.register(HTMineServiceHeaderView.self, forHeaderFooterViewReuseIdentifier: HTMineServiceHeaderView.identifier)
		return tableView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		tableView.placeholderState = .firstRefresh
		Request.list.mineServiceList { [weak self] (result) in
			let value = result.value as? [Any] ?? [Any]()
			var modelArray = HTMineServiceModel.mj_objectArray(withKeyValuesArray: value) as? [HTMineServiceModel] ?? [HTMineServiceModel]() 
			modelArray.append(HTMineServiceModel.packPhoneModel())
			self?.tableView.setCellModelArray(modelArray, proxy: self)
			self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
			self?.tableView.reloadData()
		}
	}
	
	func initInterface() {
		navigationItem.title = "客服中心"
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		tableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTMineServiceController: TableViewThrough {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineServiceCell.self
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section]
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTMineServiceHeaderView.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}

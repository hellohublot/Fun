//
//  HTDiscoverNewsContentController.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverNewsContentController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
		tableView.estimatedRowHeight = 0.0001
		tableView.estimatedSectionHeaderHeight = 0.0001
		tableView.estimatedSectionFooterHeight = 0.0001
		tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.0001))
		tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.0001))
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.register(HTDiscoverNewsContentHeaderView.self, forHeaderFooterViewReuseIdentifier: HTDiscoverNewsContentHeaderView.identifier)
		tableView.register(HTDiscoverNewsContentFooterView.self, forHeaderFooterViewReuseIdentifier: HTDiscoverNewsContentFooterView.identifier)
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
			Request.list.discoverNewsContentList(pageIndex - 1, { (result) in
				self?.reloadResponseValue(pageIndex, result, nil)
			})
		}
		tableView.respondHeaderRefresh()
	}
	
	func initInterface() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	func reloadResponseValue(_ pageIndex: Int, _ result: HTSwift.Result, _ complete: (() -> Void)?) {
		guard let value = result.value as? [Any] else {
			tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
			return
		}
		DispatchQueue.global().async {
			let modelArray = HTDiscoverNewsContentSectionModel.packModelArray(value)
			DispatchQueue.main.async {
				if pageIndex == 1 {
					self.tableView.setSectionModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self.tableView.sectionModelArray() as? [HTDiscoverNewsContentSectionModel] ?? [HTDiscoverNewsContentSectionModel]()
					existModelArray += modelArray
					self.tableView.setSectionModelArray(existModelArray, proxy: self)
				}
				self.tableView.endRefreshWith(modelCount: modelArray.count > 0 ? 10 : 0)
				self.tableView.reloadData()
				complete?()
			}
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTDiscoverNewsContentController: TableViewThrough {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = tableView.sectionModelArray()[indexPath.section] as? HTDiscoverNewsContentSectionModel
		switch sectionModel?.type {
		case .normal?:
			return HTDiscoverNewsContentNormalCell.self
		case .glad?:
			return HTDiscoverNewsContentGladCell.self
		default:
			return HTDiscoverNewsContentNormalCell.self
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTDiscoverNewsContentSectionModel
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTDiscoverNewsContentHeaderView.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 58
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let sectionModel = tableView.sectionModelArray()[indexPath.section] as? HTDiscoverNewsContentSectionModel
		switch sectionModel?.type {
		case .normal?:
			let model = sectionModel?.model
			return HTDiscoverNewsContentNormalCell.cacheModelSize(model, CGSize.init(width: tableView.bounds.size.width, height: 0)).height
		case .glad?:
			return 82
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTDiscoverNewsContentSectionModel
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTDiscoverNewsContentFooterView.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		let sectionModel = tableView.sectionModelArray()[section] as? HTDiscoverNewsContentSectionModel
		let height = HTDiscoverNewsContentFooterView.cacheModelSize(sectionModel, CGSize.init(width: tableView.bounds.size.width, height: 0)).height
		return height
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let sectionModel = tableView.sectionModelArray()[indexPath.section] as? HTDiscoverNewsContentSectionModel
		let detailController = HTDiscoverNewsDetailController()
		detailController.contentModel = sectionModel?.model

		Appdelegate.navigationController()?.pushViewController(detailController, animated: true)
	}
	
}

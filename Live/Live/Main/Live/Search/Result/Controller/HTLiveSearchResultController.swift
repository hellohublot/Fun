//
//  HTLiveSearchResultController.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTLiveSearchResultController: UIViewController {

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
		
	}
	
	func initInterface() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	func reloadResultModelArrayWithText(_ text: String) {
		
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.searchList(text, pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any] else {
					self?.tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTLiveContentModel.mj_objectArray(withKeyValuesArray: value["list"]) as? [HTLiveContentModel] ?? [HTLiveContentModel]()
				if pageIndex == 1 {
					self?.tableView.setCellModelArray(modelArray, proxy: self)
				} else {
					var existModelArray = self?.tableView.cellModelArray() as? [HTLiveContentModel] ?? [HTLiveContentModel]()
					existModelArray += modelArray
					self?.tableView.setCellModelArray(existModelArray, proxy: self)
				}
				self?.tableView.endRefreshWith(modelCount: modelArray.count)
				self?.tableView.reloadData()
			})
		}
		tableView.mj_header?.isHidden = true
		tableView.respondHeaderRefresh()
		
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTLiveSearchResultController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveSearchResultCell.self
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
		let model = tableView.cellModelArray()[indexPath.row] as? HTLiveContentModel
		let detailController = HTLiveDetailController()
		detailController.roomIdString = model?.rid
        detailController.modalPresentationStyle = .fullScreen
		Appdelegate.rootController()?.present(detailController, animated: false, completion: nil)
	}

}

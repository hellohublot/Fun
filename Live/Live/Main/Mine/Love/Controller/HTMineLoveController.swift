//
//  HTMineLoveController.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTMineLoveController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		tableView.separatorStyle = .none
		tableView.placeholderProvider = Placeholder.default
		return tableView
	}()
	
	lazy var footerView: HTMineLoveFooterView = {
		let footerView = HTMineLoveFooterView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 100))
		return footerView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.userLoveList({ (result) in
				guard let value = result.value as? [String: Any] else {
					self?.tableView.endRefreshWithOnlyOnePage(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTMineLoveModel.mj_objectArray(withKeyValuesArray: value["list"]) as? [HTMineLoveModel] ?? [HTMineLoveModel]()
				self?.tableView.setCellModelArray(modelArray, proxy: self)
				self?.tableView.endRefreshWithOnlyOnePage(modelCount: modelArray.count)
				self?.tableView.reloadData()
				self?.tableView.tableFooterView = modelArray.count > 0 ? self?.footerView : nil
			})
		}
		tableView.respondHeaderRefresh()
	}
	
	func initInterface() {
		navigationItem.title = "真爱主播"
		let questionButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "c75f3f9583c067e9d2748d6bc81687e9")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
		navigationItem.rightBarButtonItem = questionButtonItem
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTMineLoveController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineLoveCell.self
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
		return 150
	}

}

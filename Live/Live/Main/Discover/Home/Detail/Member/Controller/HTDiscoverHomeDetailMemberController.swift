//
//  HTDiscoverHomeDetailMemberController.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder

class HTDiscoverHomeDetailMemberController: UIViewController {

	var homeIdString = ""

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.separatorColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		tableView.register(HTDiscoverHomeDetailMemberHeaderView.self, forHeaderFooterViewReuseIdentifier: HTDiscoverHomeDetailMemberHeaderView.identifier)
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
		tableView.pageCount = 15
		tableView.setRefreshingBlock(Refresher.circle) { [weak self] (pageIndex, _) in
			Request.list.homeMemberList(self?.homeIdString ?? "", pageIndex - 1, { (result) in
				guard let value = result.value as? [String: Any], let homeLevelList = value["honor"] as? [String] else {
					self?.tableView.endRefreshWith(modelCount: PlaceholderState.errorNetwork.rawValue)
					return
				}
				let modelArray = HTDiscoverHomeDetailMemberModel.mj_objectArray(withKeyValuesArray: value["member"]) as? [HTDiscoverHomeDetailMemberModel] ?? [HTDiscoverHomeDetailMemberModel]()
				if pageIndex == 1 {
					let sectionModelArray = HTDiscoverHomeDetailMemberSectionModel.packModelArray(modelArray, homeLevelList)
					self?.tableView.setSectionModelArray(sectionModelArray, proxy: self)
				} else {
					var existModelArray = HTDiscoverHomeDetailMemberSectionModel.findAllMemberModelArray(self?.tableView.sectionModelArray())
					existModelArray += modelArray
					let sectionModelArray = HTDiscoverHomeDetailMemberSectionModel.packModelArray(existModelArray, homeLevelList)
					self?.tableView.setSectionModelArray(sectionModelArray, proxy: self)
				}
				self?.tableView.endRefreshWith(modelCount: modelArray.count)
				self?.tableView.reloadData()
			})
		}
		tableView.respondHeaderRefresh()
	}

	func initInterface() {
		navigationItem.title = "家族成员"
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}

extension HTDiscoverHomeDetailMemberController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTDiscoverHomeDetailMemberListCell.self
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTDiscoverHomeDetailMemberSectionModel
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTDiscoverHomeDetailMemberHeaderView.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = tableView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTDiscoverHomeDetailMemberModel
        let userController = HTMineUserController()
        userController.uidString = model?.uid ?? ""
        navigationController?.pushViewController(userController, animated: true)
    }

}

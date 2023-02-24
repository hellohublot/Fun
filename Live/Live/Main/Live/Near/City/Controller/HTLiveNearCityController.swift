//
//  HTLiveNearCityController.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveNearCityController: UIViewController {

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.separatorColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		tableView.register(HTLiveNearCityHeaderView.self, forHeaderFooterViewReuseIdentifier: HTLiveNearCityHeaderView.identifier)
		return tableView
	}()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		let sectionModelArray = HTLiveNearCitySectionModel.packModelArray()
		tableView.setSectionModelArray(sectionModelArray, proxy: self)
	}

	func initInterface() {
		navigationItem.title = "更改城市"
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}

extension HTLiveNearCityController: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveNearCityCell.self
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return reuseViewNumberOfSections(in: tableView)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reuseView(tableView, numberOfRowsInSection: section)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionModel = tableView.sectionModelArray()[section] as? HTLiveNearCitySectionModel
		let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HTLiveNearCityHeaderView.identifier)
		(cell as? ReuseCell)?.setModel(sectionModel, for: IndexPath.init(row: 0, section: section))
		return cell
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return reuseView(tableView, cellForRowAt: indexPath) as! UITableViewCell
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 25
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}

	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		let sectionModelArray = tableView.sectionModelArray() as? [HTLiveNearCitySectionModel] ?? [HTLiveNearCitySectionModel]()
		var sectionTitleArray = [String]()
		for sectionModel in sectionModelArray {
			if case .default? = sectionModel.type {
				sectionTitleArray.append(sectionModel.title ?? "")
			}
		}
		return sectionTitleArray
	}

	func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
		let sectionModelArray = tableView.sectionModelArray() as? [HTLiveNearCitySectionModel] ?? [HTLiveNearCitySectionModel]()
		for (index, sectionModel) in sectionModelArray.enumerated() {
			if sectionModel.title == title {
				return index
			}
		}
		return index
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let model = tableView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTLiveNearCityModel
		HTLiveNearCityModel.userSelectedCityName = model?.title ?? ""
		HTLiveNearLocationManager.sendSelectedOrLocationNotification()
		navigationController?.popViewController(animated: true)
	}


}

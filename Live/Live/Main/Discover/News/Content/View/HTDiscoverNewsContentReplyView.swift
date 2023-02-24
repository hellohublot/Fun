//
//  HTDiscoverNewsContentReplyView.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentReplyView: UIView, ReuseCell {

	static let replyCellHeight: CGFloat = 26

	static let replyCellMaxCount = 3

	lazy var replyTableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.backgroundColor = UIColor.clear
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		return tableView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(replyTableView)
		replyTableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let sectionModel = model as? HTDiscoverNewsContentSectionModel else {
			return
		}
		replyTableView.setCellModelArray(sectionModel.model.comment, proxy: self)
		replyTableView.reloadData()
	}

}

extension HTDiscoverNewsContentReplyView: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTDiscoverNewsContentReplyCell.self
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
		return type(of: self).replyCellHeight
	}

}

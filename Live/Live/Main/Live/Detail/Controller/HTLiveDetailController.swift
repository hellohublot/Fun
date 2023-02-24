//
//  HTLiveDetailController.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import IJKMediaFrameworkWithSSL
import HTSwift

class HTLiveDetailController: UIViewController {
	
	var roomIdString: String?
	
	var playerController: IJKFFMoviePlayerController?

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.backgroundColor = UIColor.clear
		tableView.estimatedRowHeight = 0
		tableView.isPagingEnabled = true
		tableView.allowsSelection = false
		tableView.separatorStyle = .none
		tableView.bounces = false
		return tableView
	}()

	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		tableView.setCellModelArray([roomIdString ?? ""], proxy: self)
	}
	
	func initInterface() {
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		view.layoutIfNeeded()
		scrollViewDidEndDecelerating(tableView)
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: true)
	}

	deinit {
		self.playerController?.shutdown()
	}
	
}

extension HTLiveDetailController: TableViewThrough {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let pageIndex = Int(round(scrollView.contentOffset.y / scrollView.bounds.size.height))
		guard tableView.cellModelArray().count > pageIndex, let cell = tableView.cellForRow(at: IndexPath.init(row: pageIndex, section: 0)) as? HTLiveDetailCell else {
			return
		}
		let model = tableView.cellModelArray()[pageIndex] as? String
		Request.lost.liveDetail(model ?? "") { [weak self] (result) in
			guard let value = result.value as? [String: Any], let detailModel = HTLiveDetailModel.mj_object(withKeyValues: value) else {
				return
			}
			cell.setModel(detailModel, for: IndexPath.init(row: pageIndex, section: 0))
			let liveString = detailModel.video_domain + detailModel.video_flow
			guard let playerController = IJKFFMoviePlayerController.init(contentURLString: liveString, with: IJKFFOptions.byDefault()) else {
				return
			}
			playerController.scalingMode = .aspectFit
			self?.playerController?.shutdown()
			self?.playerController = playerController
			playerController.prepareToPlay()
			playerController.play()
			cell.playerView.addSubview(playerController.view)
			playerController.view.snp.makeConstraints({ (maker) in
				maker.edges.equalTo(UIEdgeInsets.zero)
			})
		}
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if decelerate == false {
			scrollViewDidEndDecelerating(scrollView)
		}
	}

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveDetailCell.self
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
		return tableView.bounds.size.height
	}
	
}

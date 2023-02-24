//
//  HTLiveDetailControlView.swift
//  Live
//
//  Created by hublot on 2019/1/6.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import CocoaAsyncSocket

class HTLiveDetailMainView: UIView, ReuseCell {

	lazy var navigationBar: HTLiveDetailNavigationBar = {
		let navigationBar = HTLiveDetailNavigationBar.init(frame: CGRect.zero)
		return navigationBar
	}()

	lazy var chatContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.mask = gradientLayer
		return view
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 0.15, 0.85, 1]
		gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
		gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
		gradientLayer.colors = [
			UIColor.init(white: 0, alpha: 0).cgColor,
			UIColor.init(white: 0, alpha: 1).cgColor,
			UIColor.init(white: 0, alpha: 1).cgColor,
			UIColor.init(white: 0, alpha: 0).cgColor,
		]
		return gradientLayer
	}()

	lazy var chatTableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.allowsSelection = false
		tableView.estimatedRowHeight = 0
		tableView.separatorStyle = .none
		tableView.backgroundColor = UIColor.clear
		return tableView
	}()

	lazy var chatSocket: GCDAsyncSocket = {
		let socket = GCDAsyncSocket.init(delegate: self, delegateQueue: DispatchQueue.main)
		return socket
	}()

	lazy var tabbar: HTLiveDetailTabbar = {
		let tabbar = HTLiveDetailTabbar.init(frame: CGRect.zero)
		return tabbar
	}()

	lazy var toolBar: HTLiveDetailToolBar = {
		let toolBar = HTLiveDetailToolBar.init(frame: CGRect.zero)
		return toolBar
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = chatContentView.bounds
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(navigationBar)
		addSubview(tabbar)
		addSubview(toolBar)
		addSubview(chatContentView)
		chatContentView.addSubview(chatTableView)
		navigationBar.snp.makeConstraints { (maker) in
			maker.top.equalTo(HTStatic.statusHeight + 5)
			maker.left.right.equalTo(0)
			maker.height.equalTo(75)
		}
		tabbar.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(-HTStatic.tabbarHeight + 49 - 15)
			maker.left.right.equalTo(0)
			maker.height.equalTo(36)
		}
		toolBar.snp.makeConstraints { (maker) in
			maker.width.equalTo(50)
			maker.bottom.equalTo(tabbar.snp.top)
			maker.height.equalTo(100)
			maker.right.equalTo(0)
		}
		chatTableView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var model: HTLiveDetailModel?
	
	var timer: Timer?

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveDetailModel else {
			return
		}
		navigationBar.setModel(model, for: indexPath)
		self.model = model
		
		try? chatSocket.connect(toHost: "152.136.33.153", onPort: 8081)
		
		let firstModel = HTLiveDetailChatModel.init()
		firstModel.msghead = HTLiveDetailChatHeadModel.init()
		firstModel.msgbody = HTLiveDetailChatBodyModel.init()
		firstModel.msghead?.uid = model.uid
		firstModel.msghead?.rid = model.rid
		firstModel.msghead?.transmode = 0
		firstModel.msghead?.msgid = 1
		firstModel.msgbody?.token = model.roomtoken
		firstModel.msgbody?.os = 2
		willWriteModel(firstModel)
		
		timer?.invalidate()
		timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(sendKeepLiveModel), userInfo: nil, repeats: true)
		timer?.fire()
		if let timer = timer {
			RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
		}
		
	}
	
	@objc func sendKeepLiveModel() {
		let chatModel = HTLiveDetailChatModel.init()
		chatModel.msghead = HTLiveDetailChatHeadModel.init()
		chatModel.msgbody = HTLiveDetailChatBodyModel.init()
		chatModel.msghead?.uid = model?.uid ?? 0
		chatModel.msghead?.rid = model?.rid ?? 0
		chatModel.msghead?.transmode = 0
		chatModel.msghead?.msgid = 7
		willWriteModel(chatModel)
	}

}

extension HTLiveDetailMainView: TableViewThrough {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTLiveDetailChatCell.self
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
		return 40
	}

}

extension HTLiveDetailMainView: GCDAsyncSocketDelegate {

	func willWriteModel(_ chatModel: HTLiveDetailChatModel) {
		let jsonData = chatModel.mj_JSONData()
		var zipData = (jsonData as NSData?)?.zlibDeflate()
		let count = UInt8(zipData?.count ?? 0)
		zipData?.insert(count, at: 0)
		zipData?.insert(0, at: 0)
		zipData?.insert(count + 2, at: 0)
		zipData?.insert(0, at: 0)
		chatSocket.write(zipData ?? Data(), withTimeout: -1, tag: 0)
		chatSocket.readData(withTimeout: -1, tag: 0)
	}

	func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
		sock.readData(withTimeout: -1, tag: tag + 1)
		let newData = data[4..<data.count]
		let zipData = (newData as NSData).zlibInflate()
		let jsonDictionary = try? JSONSerialization.jsonObject(with: zipData, options: .mutableContainers)
		guard let chatModel = HTLiveDetailChatModel.mj_object(withKeyValues: jsonDictionary), (chatModel.msgbody?.srcnickname.count ?? 0) > 0, (chatModel.msgbody?.content.count ?? 0) > 0 else {
			return
		}
		var existModelArray = chatTableView.cellModelArray() as? [HTLiveDetailChatModel] ?? [HTLiveDetailChatModel]()
		existModelArray.append(chatModel)
		chatTableView.setCellModelArray(existModelArray, proxy: self)
		chatTableView.reloadData()
		chatTableView.scrollToRow(at: IndexPath.init(row: existModelArray.count - 1, section: 0), at: .bottom, animated: true)
	}

}

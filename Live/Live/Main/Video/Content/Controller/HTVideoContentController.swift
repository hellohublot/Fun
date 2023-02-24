//
//  HTVideoContentController.swift
//  Live
//
//  Created by hublot on 2019/1/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import AVFoundation

class HTVideoContentController: UIViewController, HTVideoRefreshController {
	
	deinit {
		NotificationCenter.default.removeObserver(self)
		HTVideoPlayer.share.player.currentItem?.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: AVPlayerItem.status)))
	}
	
	weak var delegate: HTVideoRefreshProtocol?
	
	var playerLayer: AVPlayerLayer?
	
	let scrollBackgroundQueue = DispatchQueue.init(label: "com.hublot.videoScrollBackgroundQueue")

	lazy var tableView: UITableView = {
		let tableView = UITableView.init(frame: CGRect.zero)
		tableView.separatorStyle = .none
		tableView.bounces = false
		tableView.allowsSelection = false
		tableView.backgroundColor = UIColor.clear
		tableView.showsVerticalScrollIndicator = false
		tableView.isPagingEnabled = true
		tableView.estimatedRowHeight = 0
		return tableView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		requestModelArrayIfHeaderRefresh(true)
	}
	
	func initInterface() {
		view.backgroundColor = UIColor.black
		view.addSubview(tableView)
		tableView.frame = UIScreen.main.bounds
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
	}
	
	func requestModelArrayIfHeaderRefresh(_ isHeaderRefresh: Bool) {
		if isHeaderRefresh {
			delegate?.setRefresh(true, animated: true)
		}
		Request.list.recommendVideoList { [weak self] (result) in
			if isHeaderRefresh {
				self?.delegate?.setRefresh(false, animated: true)
			}
			guard let value = result.value as? [Any] else {
				return
			}
			DispatchQueue.global().async {
				let modelArray = HTVideoContentModel.mj_objectArray(withKeyValuesArray: value) as? [HTVideoContentModel] ?? [HTVideoContentModel]()
				DispatchQueue.main.async {
					if isHeaderRefresh {
						self?.tableView.setCellModelArray(modelArray, proxy: self)
					} else {
						var existModelArray = self?.tableView.cellModelArray() as? [HTVideoContentModel] ?? [HTVideoContentModel]()
						existModelArray += modelArray
						self?.tableView.setCellModelArray(existModelArray, proxy: self)
					}
					self?.tableView.reloadData()
					if let scrollView = self?.tableView, isHeaderRefresh {
						self?.scrollViewDidEndDecelerating(scrollView)
					}
				}
			}
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		scrollViewDidEndDecelerating(tableView)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		HTVideoPlayer.share.rate = 0
	}

}

extension HTVideoContentController: TableViewThrough {
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		DispatchQueue.main.async {
			switch HTVideoPlayer.share.player.currentItem?.status {
			case .readyToPlay?:
				self.playerLayer?.isHidden = false
				HTVideoPlayer.share.rate = 1
			default:
				self.playerLayer?.isHidden = true
			}
		}
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		playerLayer?.isHidden = true
		HTVideoPlayer.share.rate = 0
		if scrollView.contentOffset.y <= 0, scrollView.panGestureRecognizer.velocity(in: scrollView).y > 10 {
			requestModelArrayIfHeaderRefresh(true)
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let pageIndex = Int(round(scrollView.contentOffset.y / scrollView.bounds.size.height))
		guard tableView.cellModelArray().count > pageIndex, let cell = tableView.cellForRow(at: IndexPath.init(row: pageIndex, section: 0)) as? HTVideoContentCell else {
			return
		}
		
		self.playerLayer?.isHidden = true
		scrollBackgroundQueue.async {
			let model = self.tableView.cellModelArray()[pageIndex] as? HTVideoContentModel
			try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
			try? AVAudioSession.sharedInstance().setActive(true)
			
			
			HTVideoPlayer.share.player.currentItem?.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: AVPlayerItem.status)))
			
			Request.lost.videoDetail("\(model?.videoid ?? 0)") { (result) in
			}
			HTVideoPlayer.share.url = Request.url(model?.videourl)
			HTVideoPlayer.share.player.volume = 0
			HTVideoPlayer.share.rate = 0
			
			NotificationCenter.default.removeObserver(self)
			NotificationCenter.default.addObserver(self, selector: #selector(self.videoPlayerItemDidEndPlay), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: HTVideoPlayer.share.player.currentItem)
			HTVideoPlayer.share.player.currentItem?.addObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: AVPlayerItem.status)), options: [.initial, .new], context: nil)
			
			DispatchQueue.main.async {
				
				let playerLayer = self.playerLayer ?? { [weak self] in
					let playerLayer = AVPlayerLayer.init(player: HTVideoPlayer.share.player)
					playerLayer.videoGravity = .resizeAspect
					self?.playerLayer = playerLayer
					return playerLayer
					}()
				
				playerLayer.removeFromSuperlayer()
				cell.playerContentView.layer.addSublayer(playerLayer)
				
				CATransaction.begin()
				CATransaction.setDisableActions(true)
				playerLayer.frame = cell.playerContentView.bounds
				CATransaction.commit()
			}
			
		}
				
		if tableView.cellModelArray().count - pageIndex <= 4 {
			requestModelArrayIfHeaderRefresh(false)
		}
				
	}
	
	@objc func videoPlayerItemDidEndPlay(_ notification: Notification) {
		DispatchQueue.main.async {
			guard let item = notification.object as? AVPlayerItem, item == HTVideoPlayer.share.player.currentItem else {
				return
			}
			HTVideoPlayer.share.rate = 0
			HTVideoPlayer.share.seekTo(0) { (finished) in
				HTVideoPlayer.share.rate = 1
			}
		}
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if decelerate == false {
			scrollViewDidEndDecelerating(scrollView)
		}
	}
	
	func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		scrollViewDidEndDecelerating(scrollView)
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTVideoContentCell.self
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

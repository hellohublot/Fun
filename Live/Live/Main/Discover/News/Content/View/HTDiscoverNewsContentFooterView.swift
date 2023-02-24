//
//  HTDiscoverNewsContentFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentFooterView: UITableViewHeaderFooterView, ReuseCell {

	static let actionContentHeight: CGFloat = 50

	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let sectionModel = model as? HTDiscoverNewsContentSectionModel else {
			return CGSize.zero
		}
		var height = actionContentHeight
		if sectionModel.showIndexReply {
			let replyContentHeight = HTDiscoverNewsContentReplyView.replyCellHeight * CGFloat(min(HTDiscoverNewsContentReplyView.replyCellMaxCount, sectionModel.model.comment.count))
			height += replyContentHeight
		}
		return CGSize.init(width: superSize.width, height: height)
	}

	lazy var replyContentView: HTDiscoverNewsContentReplyView = {
		let replyContentView = HTDiscoverNewsContentReplyView.init(frame: CGRect.zero)
		return replyContentView
	}()

	lazy var actionContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
		
	lazy var likeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 0.58, green: 0.58, blue: 0.58, alpha: 1), for: .normal)
		let normalImage = UIImage.init(named: "31e828b1666e2a16517c232f14677134")?.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 3, left: 0, bottom: 0, right: 0)) ?? UIImage()
		button.setImage(normalImage, for: .normal)
		var selectedImage = UIImage.init(named: "7d85a0f2c569d7499a8b958893c5e2f1")?.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 3, left: 0, bottom: 0, right: 0)) ?? UIImage()
		selectedImage = selectedImage.imageWith(zoom: normalImage.size.width / selectedImage.size.width)
		button.setImage(selectedImage, for: .selected)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 2)
		return button
	}()
	
	lazy var replyButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 0.58, green: 0.58, blue: 0.58, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "ca9b384cc3816ee2a5a38ef36b24717a"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var reportButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 0.58, green: 0.58, blue: 0.58, alpha: 1), for: .normal)
		button.setTitle("举报", for: .normal)
		button.setImage(UIImage.init(named: "1b607c2b725f120656456c9e287e19ae"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var separatorLineView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		return view
	}()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(replyContentView)
		addSubview(actionContentView)
		addSubview(likeButton)
		addSubview(replyButton)
		addSubview(reportButton)
		addSubview(separatorLineView)
		replyContentView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.bottom.equalTo(actionContentView.snp.top)
		}
		actionContentView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(type(of: self).actionContentHeight)
		}
		likeButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.centerY.equalTo(actionContentView)
		}
		replyButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(likeButton.snp.right).offset(50)
			maker.centerY.equalTo(actionContentView)
		}
		reportButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(replyButton.snp.right).offset(50)
			maker.centerY.equalTo(actionContentView)
		}
		separatorLineView.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func reloadCountValueWithModel(_ sectionModel: HTDiscoverNewsContentSectionModel) {
		likeButton.isSelected = sectionModel.model.ispraise == 1
		likeButton.setTitle((Int(sectionModel.model.upnum) ?? 0) > 0 ? sectionModel.model.upnum : "喜欢", for: .normal)
		replyButton.setTitle((Int(sectionModel.model.replynum) ?? 0) > 0 ? sectionModel.model.replynum : "评论", for: .normal)
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let sectionModel = model as? HTDiscoverNewsContentSectionModel else {
			return
		}
		replyContentView.setModel(model, for: indexPath)
		reloadCountValueWithModel(sectionModel)
		likeButton.whenTouch(inside: { [weak self] (_, _) in
			self?.likeButton.isSelected = !(self?.likeButton.isSelected ?? false)
			self?.likeButton.imageView?.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
			Request.lost.discoverNewsLike(sectionModel.model.dynamicid, { (result) in
				guard let value = result.value as? [String: Any], let likeCount = value["num"] as? Int else {
                    HTHud.showError(withStatus: result.error.localizedDescription)
					self?.reloadCountValueWithModel(sectionModel)
					return
				}
				sectionModel.model.ispraise = 1
				sectionModel.model.upnum = "\(likeCount)"
				self?.reloadCountValueWithModel(sectionModel)
			})
			UIView.animate(withDuration: 0.2, animations: {
				self?.likeButton.imageView?.transform = CGAffineTransform.identity
			}, completion: { (_) in

			})
		}, receive: nil)
	}

}

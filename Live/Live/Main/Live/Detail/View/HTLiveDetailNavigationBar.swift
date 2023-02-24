//
//  HTLiveDetailNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/6.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveDetailNavigationBar: UIView, ReuseCell {

	lazy var starContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.masksToBounds = true
		view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
		return view
	}()

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderColor = UIColor.white.cgColor
		imageView.layer.borderWidth = 1
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.white
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		label.lineBreakMode = .byClipping
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 10)
		label.textColor = UIColor.white
		label.setContentHuggingPriority(UILayoutPriority.init(99), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(99), for: .horizontal)
		return label
	}()

	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "28593f9c3c3539d90f05c9d0376dfce5"), for: .normal)
		return button
	}()

	lazy var seatButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "26d79f44f433abd3d1e006351bcf78a7"), for: .normal)
		return button
	}()

	lazy var fansListView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()

	lazy var fansViewList: [HTLiveDetailFansView] = {
		var fansViewList = [HTLiveDetailFansView]()
		for i in 0..<3 {
			fansViewList.append(HTLiveDetailFansView.init(frame: CGRect.zero))
		}
		return fansViewList
	}()

	lazy var closeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "d6ec3ceeb0e05a88487a73e86298e9b0"), for: .normal)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.controller?.dismiss(animated: true, completion: nil)
		})
		return button
	}()

	lazy var hotButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage.init(named: "eab0192437ecce8e478830324ab7fd1d"), for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 4, bottom: 2, right: 4)
		button.layer.masksToBounds = true
		button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 3)
		return button
	}()

	lazy var guardButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage.init(named: "ed387159ffae6ecf6319b153b1d59588"), for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 4, bottom: 2, right: 4)
		button.layer.masksToBounds = true
		button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
		button.setTitle("守护", for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 3)
		return button
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		starContentView.layer.cornerRadius = starContentView.bounds.size.height / 2.0
		hotButton.layer.cornerRadius = hotButton.bounds.size.height / 2.0
		guardButton.layer.cornerRadius = guardButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(starContentView)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(followButton)
		addSubview(seatButton)
		addSubview(fansListView)
		addSubview(closeButton)
		addSubview(hotButton)
		addSubview(guardButton)
		starContentView.snp.makeConstraints { (maker) in
			maker.top.equalTo(5)
			maker.left.equalTo(10)
			maker.width.equalTo(148)
			maker.height.equalTo(38)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(starContentView).offset(2.5)
			maker.left.equalTo(starContentView).offset(2.5)
			maker.bottom.equalTo(starContentView).offset(-2.5)
			maker.width.equalTo(headImageView.snp.height)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView)
			maker.left.equalTo(headImageView.snp.right).offset(7)
			maker.right.equalTo(followButton.snp.left).offset(-7)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(headImageView)
			maker.left.right.equalTo(titleLabel)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(starContentView).offset(-2.5)
			maker.top.equalTo(starContentView).offset(2.5)
			maker.bottom.equalTo(starContentView).offset(-2.5)
			maker.width.equalTo(followButton.snp.height)
		}
		seatButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(fansListView.snp.left)
			maker.centerY.equalTo(starContentView)
			maker.height.equalTo(30)
			maker.width.equalTo(32)
		}
		fansListView.snp.makeConstraints { (maker) in
			maker.width.equalTo(109)
			maker.height.equalTo(29)
			maker.centerY.equalTo(starContentView)
			maker.right.equalTo(closeButton.snp.left)
		}
		closeButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(starContentView)
			maker.width.height.equalTo(40)
			maker.right.equalTo(-6)
		}
		hotButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(starContentView)
			maker.top.equalTo(starContentView.snp.bottom).offset(7)
		}
		guardButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-210)
			maker.centerY.equalTo(hotButton)
		}
		for (index, fansView) in fansViewList.reversed().enumerated() {
			fansListView.addSubview(fansView)
			fansView.snp.makeConstraints { (maker) in
				maker.right.equalTo(-25 * index)
				maker.width.height.equalTo(29)
				maker.centerY.equalTo(fansListView)
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveDetailModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.nickname
		detailLabel.text = "\(model.usercount)人在线"

		let hostPriceString: String = {
			var hotPriceList = [String]()
			let size = 3
			for i in 0..<Int(ceil(CGFloat(model.hotprice.count) / CGFloat(size))) {
				let insertStringEnd = model.hotprice.index(model.hotprice.endIndex, offsetBy: -size * i)
				let insertStringStart = (insertStringEnd.encodedOffset - size) < 0 ? model.hotprice.startIndex : model.hotprice.index(insertStringEnd, offsetBy: -size)
				let insertString = String(model.hotprice[insertStringStart..<insertStringEnd])
				hotPriceList.insert(insertString, at: 0)
			}
			return hotPriceList.joined(separator: ",")
		}()
		hotButton.setTitle(hostPriceString, for: .normal)

		let userImageList = ["https://img11.img.9xiu.com/headimage/2019/01/06/41975542_15467934858659384_120x120.jpg", "https://img11.img.9xiu.com/headimage/2019/01/03/34719168_15465216210772189_120x120.png", "https://img11.img.9xiu.com/headimage/2018/12/28/46534938_15460149896999006_120x120.png"]
		for (index, fansView) in fansViewList.enumerated() {
			fansView.setModel(userImageList[index], for: IndexPath.init(row: index, section: 0))
		}
	}
	
}

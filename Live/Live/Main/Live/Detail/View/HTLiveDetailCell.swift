//
//  HTLiveDetailCell.swift
//  Live
//
//  Created by hublot on 2019/1/6.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveDetailCell: UITableViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		var image = UIImage.init(named: "d0b6b334c061b1f1cc95234444a963f2") ?? UIImage.init()
		image = image.imageAppend(image, at: CGPoint.zero)
		imageView.image = image
		return imageView
	}()

	lazy var playerView: UIView = {
		let playerView = UIView.init(frame: CGRect.zero)
		return playerView
	}()

	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView.init(frame: CGRect.zero)
		scrollView.scrollsToTop = false
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.bounces = false
		if #available(iOS 11.0, *) {
			scrollView.contentInsetAdjustmentBehavior = .never
		}
		return scrollView
	}()

	lazy var mainView: HTLiveDetailMainView = {
		let view = HTLiveDetailMainView.init(frame: CGRect.zero)
		return view
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		let scrollSize = scrollView.bounds.size
		scrollView.contentSize = CGSize.init(width: scrollSize.width * 2, height: scrollSize.height)
		mainView.frame = CGRect.init(x: scrollSize.width, y: 0, width: scrollSize.width, height: scrollSize.height)
		scrollView.contentOffset = CGPoint.init(x: scrollSize.width, y: 0)
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(scrollView)
        contentView.addSubview(playerView)
		scrollView.addSubview(mainView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		scrollView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		mainView.chatContentView.snp.remakeConstraints { (maker) in
			maker.top.equalTo(playerView.snp.bottom)
			maker.bottom.equalTo(mainView.tabbar.snp.top).offset(-10)
			maker.left.right.equalTo(0)
		}
		playerView.snp.makeConstraints { (maker) in
			maker.top.equalTo(100)
			maker.left.right.equalTo(0)
			maker.height.equalTo(playerView.snp.width).multipliedBy(3 / 4.0)
		}
	}



	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveDetailModel else {
			return
		}
		mainView.setModel(model, for: indexPath)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

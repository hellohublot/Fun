//
//  HTLiveNavigationView.swift
//  Live
//
//  Created by hublot on 2018/12/26.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTLiveNavigationBar: UIView {
	
	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
	
	lazy var pageHeaderMaskView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.mask = pageHeaderMaskLayer
		return view
	}()
	
	lazy var pageHeaderMaskLayer: CAGradientLayer = {
		let layer = CAGradientLayer.init()
		layer.startPoint = CGPoint.init(x: 0, y: 0)
		layer.endPoint = CGPoint.init(x: 1, y: 0)
		layer.colors = [
			UIColor.init(white: 0, alpha: 1).cgColor,
			UIColor.init(white: 0, alpha: 1).cgColor,
			UIColor.init(white: 0, alpha: 0).cgColor,
		]
		layer.locations = [0, 0.85, 1]
		return layer
	}()

	lazy var pageHeaderView: HTPageHeaderView = {
		let pageHeaderView = HTPageHeaderView.init(frame: CGRect.zero)
		return pageHeaderView
	}()
	
	lazy var searchButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "b8a87d2e888dc9f31fe7287bef559eca")
		button.setImage(image, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 7)
		button.whenTouch(inside: { [weak self] (_, _) in
			let searchController = HTLiveSearchController()
			self?.controller?.navigationController?.pushViewController(searchController, animated: true)
		})
		return button
	}()
	
	lazy var historyButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "89dabecf1f67e4fb4f5bb9bef84ea721")
		button.setImage(image, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 7, bottom: 0, right: 15)
		button.whenTouch(inside: { [weak self] (_, _) in
			let historyController = HTLiveHistoryController()
			self?.controller?.navigationController?.pushViewController(historyController, animated: true)
		})
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		pageHeaderMaskLayer.frame = pageHeaderMaskView.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize.init(width: 0, height: 1)
		layer.shadowOpacity = 0.05
		
		addSubview(navigationContentView)
		addSubview(pageHeaderMaskView)
		pageHeaderMaskView.addSubview(pageHeaderView)
		addSubview(searchButton)
		addSubview(historyButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.top.equalTo(HTStatic.statusHeight)
			maker.left.right.bottom.equalTo(0)
		}
		pageHeaderMaskView.snp.makeConstraints { (maker) in
			maker.left.top.bottom.equalTo(navigationContentView)
			maker.right.equalTo(searchButton.snp.left)
		}
		pageHeaderView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		searchButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(navigationContentView)
			maker.right.equalTo(historyButton.snp.left)
		}
		historyButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(navigationContentView)
			maker.right.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

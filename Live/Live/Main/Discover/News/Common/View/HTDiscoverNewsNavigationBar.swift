//
//  HTDiscoverNewsNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverNewsNavigationBar: UIView {

	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
	
	lazy var backButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "98c1e876c72d8b6ece5fec12b18993fd")?.withRenderingMode(.alwaysOriginal)
		button.setImage(image, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.controller?.navigationController?.popViewController(animated: true)
		})
		return button
	}()
	
	lazy var pageHeaderView: HTPageHeaderView = {
		let pageHeaderView = HTPageHeaderView.init(frame: CGRect.zero)
		return pageHeaderView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize.init(width: 0, height: 1)
		layer.shadowOpacity = 0.05

		addSubview(navigationContentView)
		addSubview(pageHeaderView)
		addSubview(backButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.equalTo(HTStatic.statusHeight)
			maker.height.equalTo(HTStatic.navigationHeight - HTStatic.statusHeight)
		}
		backButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.centerY.equalTo(navigationContentView)
		}
		pageHeaderView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(navigationContentView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

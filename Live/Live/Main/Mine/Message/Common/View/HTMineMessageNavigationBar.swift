//
//  HTMineMessageNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/9.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineMessageNavigationBar: UIView {
	
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
	
	lazy var ignoreButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.setTitle("忽略未读", for: .normal)
		button.setTitle("", for: .selected)
		button.setImage(nil, for: .normal)
		button.setImage(UIImage.init(named: "a4f22eda78944c0cb39a8cebeedd8669"), for: .selected)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(navigationContentView)
		addSubview(pageHeaderView)
		addSubview(backButton)
		addSubview(ignoreButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.statusHeight, left: 0, bottom: 0, right: 0))
		}
		backButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.centerY.equalTo(navigationContentView)
		}
		pageHeaderView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.bottom.equalTo(navigationContentView)
		}
		ignoreButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-10)
			maker.centerY.equalTo(navigationContentView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

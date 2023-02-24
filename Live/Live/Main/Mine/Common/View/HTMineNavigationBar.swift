//
//  HTMineNavigationBar.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTMineNavigationBar: UIView {
	
	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = UIColor.white
		label.text = "我的"
		return label
	}()
	
	lazy var setupButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "9781612014dae82e75cd9e621c4633c2")?.withRenderingMode(.alwaysTemplate)
		button.setImage(image, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
		button.whenTouch(inside: { [weak self] (_, _) in
			if HTUserAuthManager.isLogin() {
				let setupController = HTSetupController()
				self?.controller?.navigationController?.pushViewController(setupController, animated: true)
			} else {
				HTUserAuthManager.showLoginController()
			}
		})
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
				
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize.init(width: 0, height: 1)
		layer.shadowOpacity = 0.05

		addSubview(navigationContentView)
		addSubview(titleLabel)
		addSubview(setupButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.statusHeight, left: 0, bottom: 0, right: 0))
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.center.equalTo(navigationContentView)
		}
		setupButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-12)
			maker.centerY.equalTo(navigationContentView)
		}
	}
	
	func reloadCollectionContentOffset(_ offset: CGFloat) {
		var backgroundColor: UIColor?
		var tintColor: UIColor?
		if offset >= 0 {
			backgroundColor = UIColor.clear
			tintColor = UIColor.white
		} else {
			backgroundColor = UIColor.init(white: 1, alpha: -offset / 64.0)
			tintColor = UIColor.init(white: 1 - (-offset / 64.0), alpha: 1)
		}
		self.backgroundColor = backgroundColor
		titleLabel.textColor = tintColor
		setupButton.tintColor = tintColor
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

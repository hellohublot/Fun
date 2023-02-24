//
//  HTMineUserNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineUserNavigationBar: UIView {
	
	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()

	lazy var backButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "98c1e876c72d8b6ece5fec12b18993fd")?.withRenderingMode(.alwaysTemplate)
		button.setImage(image, for: .normal)
		button.tintColor = UIColor.white
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.controller?.navigationController?.popViewController(animated: true)
		})
		return button
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = UIColor.white
		label.text = "个人资料"
		return label
	}()
	
	lazy var moreButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "a464c849cf6335e3fb74628f510b9e14")?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.tintColor = UIColor.white
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(navigationContentView)
		addSubview(backButton)
		addSubview(titleLabel)
		addSubview(moreButton)
		navigationContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.statusHeight, left: 0, bottom: 0, right: 0))
		}
		backButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.centerY.equalTo(navigationContentView)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.center.equalTo(navigationContentView)
		}
		moreButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(navigationContentView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}

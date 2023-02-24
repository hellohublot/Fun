//
//  HTDiscoverHomeCircleHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeCircleHeaderView: UICollectionReusableView, ReuseCell {

	lazy var searchTextField: UITextField = {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		let leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 30))
		leftImageView.contentMode = .center
		leftImageView.layer.masksToBounds = true
		leftImageView.image = UIImage.init(named: "c5c05e0b232325114d0df70552545234")
		textField.leftView = leftImageView
		textField.leftViewMode = .always
		textField.font = UIFont.systemFont(ofSize: 14)
		textField.textColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
		textField.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
		textField.layer.masksToBounds = true
		textField.placeholder = "输入家族名称或徽章"
		textField.whenTouch(inside: { [weak self] (_, _) in
			let searchController = HTDiscoverHomeSearchController()
			self?.controller?.navigationController?.pushViewController(searchController, animated: true)
		})
		return textField
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		searchTextField.layer.cornerRadius = searchTextField.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(searchTextField)
		searchTextField.snp.makeConstraints { (maker) in
			maker.left.equalTo(10)
			maker.right.equalTo(-10)
			maker.height.equalTo(30)
			maker.centerY.equalTo(self)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		
	}

}

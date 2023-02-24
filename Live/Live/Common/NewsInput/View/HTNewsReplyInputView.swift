//
//  HTNewsReplyInputView.swift
//  Live
//
//  Created by hublot on 2019/3/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTNewsReplyInputView: UIView {

	lazy var contentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
		return view
	}()

	lazy var switchButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: ""), for: .normal)
		button.setImage(UIImage.init(named: ""), for: .selected)
		return button
	}()



}

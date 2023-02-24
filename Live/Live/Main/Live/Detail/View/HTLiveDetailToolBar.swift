//
//  HTLiveDetailToolBar.swift
//  Live
//
//  Created by hublot on 2019/1/6.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveDetailToolBar: UIView {

	lazy var firstButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "14d1513eea2438971c441d347370ad26"), for: .normal)
		return button
	}()

	lazy var bagButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "018c489b5a3d5955f4963dd1d2c5bfeb"), for: .normal)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(firstButton)
		addSubview(bagButton)
		firstButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-12)
			maker.bottom.equalTo(bagButton.snp.top).offset(-30)
			maker.width.height.equalTo(30)
		}
		bagButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(firstButton)
			maker.bottom.equalTo(-20)
			maker.width.height.equalTo(firstButton)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

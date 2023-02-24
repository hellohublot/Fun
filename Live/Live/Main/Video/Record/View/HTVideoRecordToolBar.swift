//
//  HTVideoRecordToolBar.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTVideoRecordToolBar: UIView {

	lazy var beautifulButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "e7663bd22a1b716a0f38dacceab8412f"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("美颜", for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var glassButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "5fa9a20eab8f015003bde178d32c2b75"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("滤镜", for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var musicButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "527e161c95f75a3c9b79293bbe21b82b"), for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("配乐", for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 5)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(beautifulButton)
		addSubview(glassButton)
		addSubview(musicButton)
		beautifulButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-10)
			maker.bottom.equalTo(glassButton.snp.top).offset(-20)
		}
		glassButton.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(beautifulButton)
			maker.bottom.equalTo(musicButton.snp.top).offset(-20)
		}
		musicButton.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(beautifulButton)
			maker.bottom.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

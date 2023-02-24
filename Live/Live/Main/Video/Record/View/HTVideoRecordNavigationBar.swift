//
//  HTVideoRecordNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTVideoRecordNavigationBar: UIView {

	lazy var exitButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "734e79e2226f738206795dfe47fb95f7"), for: .normal)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.controller?.dismiss(animated: true, completion: nil)
		})
		return button
	}()
	
	lazy var photoButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "d17ef50be1107092efe984e76721d544"), for: .normal)
		return button
	}()
	
	lazy var timerButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "fc1e5c5d84f1f346287491f019522772"), for: .normal)
		return button
	}()
	
	lazy var flashButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "620906b6b1361b8d916eff4c0986b1e0"), for: .normal)
		return button
	}()
	
	lazy var positionButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "75ce1da9b2c30eb1c58ff0dfe1fddc21"), for: .normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(exitButton)
		addSubview(photoButton)
		addSubview(timerButton)
		addSubview(flashButton)
		addSubview(positionButton)
		exitButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(6)
			maker.top.equalTo(HTStatic.statusHeight)
		}
		photoButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(positionButton)
			maker.right.equalTo(timerButton.snp.left).offset(-20)
		}
		timerButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(positionButton)
			maker.right.equalTo(flashButton.snp.left).offset(-20)
		}
		flashButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(positionButton)
			maker.right.equalTo(positionButton.snp.left).offset(-20)
		}
		positionButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(exitButton)
			maker.right.equalTo(-6)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

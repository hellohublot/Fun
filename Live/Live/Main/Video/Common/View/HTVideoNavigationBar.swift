//
//  HTVideoNavigationBar.swift
//  Live
//
//  Created by hublot on 2019/1/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTVideoNavigationBar: UIView {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "2fc44a634f824013805853c0f6d5cd34")
		return imageView
	}()
	
	lazy var navigationContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
	
	lazy var refreshView: HTVideoRefreshView = {
		let refreshView = HTVideoRefreshView.init(frame: CGRect.zero)
		return refreshView
	}()
	
	lazy var pageHeaderView: HTVideoPageHeaderView = {
		let pageHeaderView = HTVideoPageHeaderView.init(frame: CGRect.zero)
		return pageHeaderView
	}()
	
	lazy var cameraButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "8a8530f0750d17bd7aa4c9f907c91ba8")
		button.setImage(image, for: .normal)
		button.whenTouch(inside: { [weak self] (_, _) in
			let recordController = HTVideoRecordController()
            recordController.modalPresentationStyle = .fullScreen
			self?.controller?.present(recordController, animated: true, completion: nil)
		})
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(navigationContentView)
		addSubview(refreshView)
		addSubview(pageHeaderView)
		addSubview(cameraButton)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.bottom.equalTo(44)
		}
		navigationContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.statusHeight, left: 0, bottom: 0, right: 0))
		}
		refreshView.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(navigationContentView)
		}
		pageHeaderView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.bottom.equalTo(navigationContentView)
		}
		cameraButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(navigationContentView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

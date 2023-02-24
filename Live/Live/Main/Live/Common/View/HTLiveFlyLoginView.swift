//
//  HTLiveFlyLoginView.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTLiveFlyLoginView: UIView {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "7674b27a112a02d5ce11021390b3006a")
		imageView.image = image
		return imageView
	}()
	
	lazy var loginTitleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 19)
		label.textColor = UIColor.white
		label.textAlignment = .center
		label.text = "登录"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		isHidden = true
		whenTouch(inside: { (_, _) in
			HTUserAuthManager.showLoginController()
		})
		addSubview(backgroundImageView)
		addSubview(loginTitleLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		loginTitleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 8))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		return backgroundImageView.intrinsicContentSize
	}

}

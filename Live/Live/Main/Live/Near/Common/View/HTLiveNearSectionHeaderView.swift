//
//  HTLiveNearSectionHeaderView.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveNearSectionHeaderView: UICollectionReusableView, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 10)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.isUserInteractionEnabled = false
		button.setImage(UIImage.init(named: "5208115ea621f869f2f9b6a19a1246a3"), for: .normal)
		button.setTitle("城市", for: .normal)
		return button
	}()

	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "3bf3cb5370d39e6f70e8128f705b4462"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: -5)
		return button
	}()

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "78c5fb685085a7f6f432f0f2902952a6")
		imageView.whenTouch(inside: { [weak self] (_, _) in
			if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
				UIApplication.shared.openURL(url)
			}
		})
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.masksToBounds = true
		addSubview(backgroundImageView)
		addSubview(titleButton)
		addSubview(detailButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(12)
			maker.right.equalTo(detailButton.snp.left).offset(-10)
			maker.top.equalTo(0)
			maker.height.equalTo(45)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-12)
			maker.top.height.equalTo(titleButton)
		}
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleButton.snp.bottom)
			maker.left.right.equalTo(0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		detailButton.isHidden = !HTLiveNearLocationManager.locationAuthorization
		detailButton.setTitle(HTLiveNearCityModel.packCurrentCityModel(true)?.title, for: .normal)
		detailButton.whenTouch(inside: { (_, _) in
			let cityController = HTLiveNearCityController()
			Appdelegate.navigationController()?.pushViewController(cityController, animated: true)
		})
	}
        
}

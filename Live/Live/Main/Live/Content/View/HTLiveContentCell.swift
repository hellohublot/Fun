//
//  HTLiveContentCell.swift
//  Live
//
//  Created by hublot on 2018/12/26.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveContentCell: UICollectionViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.setContentHuggingPriority(UILayoutPriority.init(100), for: .vertical)
		imageView.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .vertical)
		imageView.layer.cornerRadius = darkGradientLayer.cornerRadius
		imageView.layer.addSublayer(darkGradientLayer)
		return imageView
	}()
	
	lazy var darkGradientLayer: CALayer = {
		let layer = CAGradientLayer.init()
		layer.colors = [
			UIColor.init(white: 0, alpha: 0).cgColor,
			UIColor.init(white: 0, alpha: 0).cgColor,
			UIColor.init(white: 0, alpha: 0.3).cgColor
		]
		layer.locations = [0, 0.5, 1]
		layer.startPoint = CGPoint.zero
		layer.endPoint = CGPoint.init(x: 0, y: 1)
		layer.cornerRadius = 5
		layer.masksToBounds = true
		return layer
	}()
	
	lazy var pkTitleImage: CAGradientLayer = {
		let layer = CAGradientLayer.init()
		layer.colors = [
			UIColor.init(red: 1, green: 0.752941, blue: 0.462745, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.482353, blue: 0.611765, alpha: 1).cgColor
		]
		layer.locations = [0, 1]
		layer.startPoint = CGPoint.zero
		layer.endPoint = CGPoint.init(x: 1, y: 0)
		layer.cornerRadius = 3
		layer.masksToBounds = true
		return layer
	}()
	
	lazy var pkTitleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
		button.setTitleColor(UIColor.white, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 3, left: 5, bottom: 3, right: 5)
		button.layer.insertSublayer(pkTitleImage, at: 0)
		return button
	}()

	lazy var flagTitleImage: CAGradientLayer = {
		let layer = CAGradientLayer.init()
		layer.colors = [
			UIColor.init(red: 1, green: 0.752941, blue: 0.462745, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.482353, blue: 0.611765, alpha: 1).cgColor
		]
		layer.locations = [0, 1]
		layer.startPoint = CGPoint.zero
		layer.endPoint = CGPoint.init(x: 1, y: 0)
		layer.cornerRadius = 3
		layer.masksToBounds = true
		return layer
	}()

	lazy var flagTitleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
		button.setTitleColor(UIColor.white, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 3, left: 5, bottom: 3, right: 5)
		button.layer.insertSublayer(flagTitleImage, at: 0)
		return button
	}()
    
    lazy var flagImageButton: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        return button
    }()

	lazy var visitCountButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage.init(named: "e3d1cb5b90d4e5c456f7cd84b00111fd"), for: .normal)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return button
	}()

	lazy var cityNameLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 13)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		darkGradientLayer.frame = backgroundImageView.bounds
		pkTitleImage.frame = pkTitleButton.bounds
		flagTitleImage.frame = flagTitleButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(flagTitleButton)
        addSubview(flagImageButton)
		addSubview(pkTitleButton)
		addSubview(visitCountButton)
		addSubview(cityNameLabel)
		addSubview(titleLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
			maker.bottom.equalTo(titleLabel.snp.top).offset(-10)
		}
		flagTitleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(backgroundImageView).offset(5)
			maker.top.equalTo(backgroundImageView)
		}
        flagImageButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(flagTitleButton)
            maker.top.equalTo(backgroundImageView)
        }
		pkTitleButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(backgroundImageView).offset(-5)
			maker.top.equalTo(backgroundImageView).offset(0)
		}
		visitCountButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(backgroundImageView).offset(5)
			maker.bottom.equalTo(backgroundImageView).offset(-5)
		}
		cityNameLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(visitCountButton.snp.right).offset(10)
			maker.right.equalTo(-10)
			maker.centerY.equalTo(visitCountButton)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.bottom.equalTo(-4)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveContentModel else {
			return
		}
        if model.flagImageString.count > 0 {
            flagImageButton.isHidden = false
            flagTitleButton.isHidden = true
            flagImageButton.setImage(UIImage.init(named: model.flagImageString), for: .normal)
        } else {
            flagImageButton.isHidden = true
            flagTitleButton.isHidden = (flagTitleButton.currentTitle?.count ?? 0) <= 0
            flagTitleButton.setTitle(model.flagTitleString, for: .normal)
            flagTitleImage.colors = model.flagGradientColorList
        }

		pkTitleButton.setTitle(model.pkContentString, for: .normal)
		pkTitleButton.isHidden = (pkTitleButton.currentTitle?.count ?? 0) <= 0

		backgroundImageView.kf.setImage(with: Request.url(model.phonehallposter), placeholder: Request.placeImage)
		titleLabel.text = model.nickname
		visitCountButton.setTitle("\(model.usercount)", for: .normal)
		cityNameLabel.text = model.showCityTitle ? model.city : ""
	}
    
}

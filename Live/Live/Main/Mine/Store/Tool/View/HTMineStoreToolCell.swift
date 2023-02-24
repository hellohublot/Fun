//
//  HTMineStoreToolCell.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreToolCell: UITableViewCell, ReuseCell {

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 5, bottom: 2, right: 5)
		button.layer.cornerRadius = 3
		button.layer.borderWidth = 1 / UIScreen.main.scale
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.masksToBounds = true
		return button
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()

	lazy var moneyLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		return gradientLayer
	}()

	lazy var payButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("购买", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		contentView.addSubview(backgroundImageView)
		backgroundImageView.addSubview(titleButton)
		backgroundImageView.addSubview(detailLabel)
		backgroundImageView.addSubview(moneyLabel)
		addSubview(payButton)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.width.equalTo(360)
			maker.height.equalTo(210)
			maker.top.equalTo(5)
			maker.centerX.equalTo(self)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(45)
			maker.top.equalTo(20)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.top.equalTo(50)
			maker.bottom.equalTo(-15)
			maker.width.equalTo(backgroundImageView).multipliedBy(0.48)
		}
		moneyLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-20)
			maker.top.equalTo(60)
		}
		payButton.snp.makeConstraints { (maker) in
			maker.top.equalTo(moneyLabel.snp.bottom).offset(30)
			maker.right.equalTo(moneyLabel)
			maker.width.equalTo(95)
			maker.height.equalTo(30)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = payButton.bounds
		payButton.layer.cornerRadius = payButton.bounds.size.height / 2.0
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreToolModel else {
			return
		}
		backgroundImageView.image = UIImage.init(named: model.image ?? "")
		titleButton.setTitle(model.title, for: .normal)
		detailLabel.attributedText = {
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.lineSpacing = 8
			paragraphStyle.alignment = .left
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: model.detail ?? "", attributes: [
				.font: UIFont.boldSystemFont(ofSize: 14),
				.foregroundColor: UIColor.white,
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.text ?? ""), attributes: [
				.font: UIFont.systemFont(ofSize: 11),
				.foregroundColor: UIColor.white,
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
		moneyLabel.attributedText = {
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.lineSpacing = 15
			paragraphStyle.alignment = .right
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: model.buyCoin ?? "", attributes: [
				.font: UIFont.boldSystemFont(ofSize: 17),
				.foregroundColor: model.titleColor ?? UIColor.clear,
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.payMoney ?? ""), attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: model.titleColor ?? UIColor.clear,
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
		gradientLayer.colors = model.colorList
	}

}

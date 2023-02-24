//
//  HTMineLoveCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineLoveCell: UITableViewCell, ReuseCell {
	
	lazy var whiteContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		return view
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.black
		return label
	}()
	
	lazy var levelButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
		button.setTitleColor(UIColor.init(red: 1, green: 0.25, blue: 0.38, alpha: 1), for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 3, left: 5, bottom: 3, right: 5)
		button.layer.borderColor = UIColor.init(red: 1, green: 0.25, blue: 0.38, alpha: 1).cgColor
		button.layer.borderWidth = 1 / UIScreen.main.scale
		return button
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var cancelButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.init(red: 1, green: 0.25, blue: 0.38, alpha: 1), for: .normal)
		button.setTitle("取消佩戴", for: .normal)
		button.layer.borderWidth = 1 / UIScreen.main.scale
		button.layer.borderColor = UIColor.init(red: 1, green: 0.25, blue: 0.38, alpha: 1).cgColor
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
		return button
	}()
	
	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		return view
	}()
	
	lazy var loveLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var expireLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor,
		]
		return gradientLayer
	}()
	
	lazy var continueButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("续费", for: .normal)
		button.layer.masksToBounds = true
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 18, bottom: 5, right: 18)
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		levelButton.layer.cornerRadius = levelButton.bounds.size.height / 2.0
		cancelButton.layer.cornerRadius = cancelButton.bounds.size.height / 2.0
		continueButton.layer.cornerRadius = continueButton.bounds.size.height / 2.0
		gradientLayer.frame = continueButton.bounds
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		addSubview(whiteContentView)
		addSubview(separatorView)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(levelButton)
		addSubview(detailLabel)
		addSubview(cancelButton)
		addSubview(loveLabel)
		addSubview(expireLabel)
		addSubview(continueButton)
		whiteContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.top.equalTo(15)
			maker.width.height.equalTo(45)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.top.equalTo(headImageView)
		}
		levelButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel.snp.right).offset(10)
			maker.centerY.equalTo(titleLabel)
		}
		cancelButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(headImageView)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(15)
			maker.left.equalTo(titleLabel)
		}
		separatorView.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(30)
			maker.left.equalTo(0)
			maker.right.equalTo(0)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
		loveLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView)
			maker.top.equalTo(separatorView.snp.bottom).offset(15)
		}
		expireLabel.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(loveLabel)
			maker.right.equalTo(continueButton.snp.left).offset(-20)
		}
		continueButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(cancelButton)
			maker.centerY.equalTo(loveLabel)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineLoveModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.badgeTitle
		levelButton.setTitle("LV\(model.loveLevel)", for: .normal)
		detailLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: "主播: ", attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
			]))
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
			]))
			return attributedString
		}()
		cancelButton.isHidden = model.is_expire
		loveLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: "我的真爱值: ", attributes: [
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.init(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
			]))
			attributedString.append(NSAttributedString.init(string: model.points, attributes: [
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
			]))
			return attributedString
		}()
		expireLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			if model.is_expire {
				attributedString.append(NSAttributedString.init(string: "已到期", attributes: [
					.font: UIFont.systemFont(ofSize: 13),
					.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
				]))
			} else {
				attributedString.append(NSAttributedString.init(string: "到期 ", attributes: [
					.font: UIFont.systemFont(ofSize: 13),
					.foregroundColor: UIColor.init(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
				]))
				let dateFormatter = DateFormatter.init()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				let date = Date.init(timeIntervalSince1970: TimeInterval(model.expire) ?? 0)
				let dateString = dateFormatter.string(from: date)
				attributedString.append(NSAttributedString.init(string: dateString, attributes: [
					.font: UIFont.systemFont(ofSize: 13),
					.foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
				]))
			}
			return attributedString
		}()
		
	}

}

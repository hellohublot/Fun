//
//  HTDiscoverHomeRecommendCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeRecommendCell: UICollectionViewCell, ReuseCell {

	lazy var shadowContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.cornerRadius = 5
		view.layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		view.layer.shadowOpacity = 0.11
		view.layer.shadowRadius = 12
		view.layer.shadowOffset = CGSize.init(width: 0, height: 3)
		view.layer.borderWidth = 1 / UIScreen.main.scale
		view.layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor
		return view
	}()

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 3
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		var image = UIImage.init(named: "a960ebb16780500688396bffb96bd4a7")
		image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), resizingMode: .stretch)
		button.setBackgroundImage(image, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 3, bottom: 2, right: 3)
		return button
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(101), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(101), for: .horizontal)
		return label
	}()

	lazy var separatorLine: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		return view
	}()

	lazy var countLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(shadowContentView)
		shadowContentView.addSubview(headImageView)
		shadowContentView.addSubview(flagImageView)
		shadowContentView.addSubview(titleLabel)
		shadowContentView.addSubview(titleButton)
		shadowContentView.addSubview(detailLabel)
		shadowContentView.addSubview(separatorLine)
		shadowContentView.addSubview(countLabel)
		shadowContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10))
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(8)
			maker.top.equalTo(8)
			maker.bottom.equalTo(-8)
			maker.width.equalTo(100)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(shadowContentView).offset(-5)
			maker.top.equalTo(shadowContentView).offset(-5)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(10)
			maker.top.equalTo(headImageView)
			maker.right.equalTo(separatorLine.snp.left).offset(-10)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleLabel.snp.bottom).offset(8)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleButton.snp.bottom).offset(12)
			maker.right.equalTo(separatorLine.snp.left).offset(-10)
		}
		separatorLine.snp.makeConstraints { (maker) in
			maker.right.equalTo(countLabel.snp.left).offset(-5)
			maker.width.equalTo(1 / UIScreen.main.scale)
			maker.height.equalTo(shadowContentView).multipliedBy(0.8)
			maker.centerY.equalTo(shadowContentView)
		}
		countLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(shadowContentView).offset(-5)
			maker.centerY.equalTo(shadowContentView)
			maker.width.equalTo(80)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.fbackground), placeholder: Request.placeImage)
		if model.showFlagImage {
			var flagImageString = ""
			switch indexPath.row {
			case 0:
				flagImageString = "140557c4a46a14bf71d8c9d1d7e7a98e"
			case 1:
				flagImageString = "fbd28f9ee2e38e93ee7bc613b9c55e6e"
			case 2:
				flagImageString = "fb6579229dc69691a6dcb4c620f535c3"
			default:
				break
			}
			flagImageView.image = UIImage.init(named: flagImageString)
		}
		titleLabel.text = model.fname
		titleButton.setTitle(model.fbadge, for: .normal)
		detailLabel.text = "家族: \(model.nickname)"
		countLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .center
			attributedString.append(NSAttributedString.init(string: "\(model.anchornum)", attributes: [
				.font: UIFont.systemFont(ofSize: 14),
				.foregroundColor: UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "/\(model.membernum)", attributes: [
				.font: UIFont.systemFont(ofSize: 14),
				.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
	}
    
}

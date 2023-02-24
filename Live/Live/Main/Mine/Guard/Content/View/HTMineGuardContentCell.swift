//
//  HTMineGuardContentCell.swift
//  Live
//
//  Created by hublot on 2019/1/22.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import Kingfisher

class HTMineGuardContentCell: UITableViewCell, ReuseCell {
	
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
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		return view
	}()
	
	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.contentHorizontalAlignment = .left
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()
	
	lazy var switchControl: UISwitch = {
		let switchControl = UISwitch.init(frame: CGRect.zero)
		switchControl.onTintColor = UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
		return switchControl
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
		gradientLayer.frame = continueButton.bounds
		continueButton.layer.cornerRadius = continueButton.bounds.size.height / 2.0
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		addSubview(whiteContentView)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(separatorView)
		addSubview(detailButton)
		addSubview(switchControl)
		addSubview(continueButton)
		whiteContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.top.equalTo(15)
			maker.width.height.equalTo(50)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.centerY.equalTo(headImageView)
			maker.right.equalTo(continueButton.snp.left).offset(-15)
		}
		separatorView.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(20)
			maker.left.equalTo(headImageView)
			maker.right.equalTo(0)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView)
			maker.right.equalTo(continueButton.snp.left).offset(-15)
			maker.top.equalTo(separatorView.snp.bottom).offset(15)
		}
		switchControl.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(headImageView)
		}
		continueButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(detailButton)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineGuardContentModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.text = "守护\(model.anchor_nickname)"
		detailButton.setTitle("还有\(model.dueTime)天到期", for: .normal)
		let imageModifier = AnyImageModifier.init(modify: { (fromImage) -> UIImage in
			let scale = 25 / fromImage.size.height
			return fromImage.imageWith(zoom: scale)
		})
		detailButton.kf.setImage(with: Request.url(model.url), for: .normal, placeholder: Request.placeImage, options: [.imageModifier(imageModifier)])

	}

}

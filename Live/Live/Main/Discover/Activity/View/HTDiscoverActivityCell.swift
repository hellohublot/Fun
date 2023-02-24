//
//  HTDiscoverActivityCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverActivityCell: UITableViewCell, ReuseCell {

	lazy var radiusContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		return view
	}()

	lazy var shadowContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		view.layer.cornerRadius = radiusContentView.layer.cornerRadius
		view.layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		view.layer.shadowOpacity = 0.11
		view.layer.shadowRadius = 12
		view.layer.shadowOffset = CGSize.init(width: 0, height: 3)
		view.layer.borderWidth = 1 / UIScreen.main.scale
		view.layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor
		return view
	}()

	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.setContentHuggingPriority(UILayoutPriority.init(100), for: .vertical)
		imageView.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .vertical)
		return imageView
	}()

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.from(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)).imageWith(size: CGSize.init(width: 2, height: 12))
		button.setImage(image, for: .normal)
		button.imageView?.layer.masksToBounds = true
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		button.setTitleColor(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1), for: .normal)
		button.contentHorizontalAlignment = .left
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		button.isUserInteractionEnabled = false
		return button
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		return label
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		titleButton.imageView?.layer.cornerRadius = (titleButton.imageView?.bounds.size.width ?? 0) / 2.0
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = UIColor.clear
//		layer.masksToBounds = false
		selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		addSubview(shadowContentView)
		addSubview(radiusContentView)
		radiusContentView.addSubview(backgroundImageView)
		addSubview(titleButton)
		radiusContentView.addSubview(detailLabel)
		shadowContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 15, left: 15, bottom: 0, right: 15))
		}
		radiusContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(shadowContentView)
		}
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(radiusContentView)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(radiusContentView).offset(15)
			maker.right.equalTo(radiusContentView).offset(-15)
			maker.top.equalTo(backgroundImageView.snp.bottom).offset(10)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(titleButton)
			maker.top.equalTo(titleButton.snp.bottom).offset(8)
			maker.bottom.equalTo(radiusContentView).offset(-10)
		}

	}

	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		shadowContentView.backgroundColor = UIColor.white
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		setHighlighted(selected, animated: animated)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverActivityModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.act_img), placeholder: Request.placeImage)
		titleButton.setTitle(model.act_desc, for: .normal)
		detailLabel.text = model.time
	}

}

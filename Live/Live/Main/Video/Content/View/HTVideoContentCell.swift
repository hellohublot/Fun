//
//  HTVideoContentCell.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoContentCell: UITableViewCell, ReuseCell {
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var playerContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
	
	lazy var darkImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "83b1363ec08e2d4b0c9a8e2d4327df6c")
		return imageView
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderWidth = 1
		imageView.layer.borderColor = UIColor.white.cgColor
		return imageView
	}()
	
	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "75c287d2bfd40a80a482e0454a3e7c94")
		button.setImage(image, for: .normal)
		return button
	}()
	
	lazy var likeButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "27d2c09f642a28df25bcb119f5075728")
		button.setImage(image, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 10)
		return button
	}()
	
	lazy var replyButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "6fbc534bd3f9ab2ecee5beb6c7f4a71a")
		button.setImage(image, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 10)
		return button
	}()
	
	lazy var shareButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		let image = UIImage.init(named: "fbf8050e11c3a2b5de67641626f203f8")
		button.setImage(image, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.ht_makeEdge(with: .vertical, imageToTitleaOffset: 10)
		return button
	}()
	
	lazy var musicImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "46a862d6faf43c1dcf352541ac6d8049")
		imageView.image = image
		return imageView
	}()
	
	lazy var nickNameLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var contentLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
		label.numberOfLines = 0
		return label
	}()
	
	lazy var animationImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "b8163d5b9a2b77d33759982449da67f5")
		imageView.image = image
		return imageView
	}()
	
	lazy var animationLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		addSubview(backgroundImageView)
		addSubview(playerContentView)
		addSubview(darkImageView)
		addSubview(headImageView)
		addSubview(followButton)
		addSubview(likeButton)
		addSubview(replyButton)
		addSubview(shareButton)
		addSubview(musicImageView)
		addSubview(nickNameLabel)
		addSubview(contentLabel)
		addSubview(animationImageView)
		addSubview(animationLabel)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		playerContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(backgroundImageView)
		}
		darkImageView.snp.makeConstraints { (maker) in
			maker.bottom.left.right.equalTo(0)
			maker.height.equalTo(293)
		}
		animationImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(11)
			maker.bottom.equalTo(-HTStatic.tabbarHeight - 10)
		}
		animationLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(animationImageView.snp.right).offset(3)
			maker.centerY.equalTo(animationImageView)
			maker.right.equalTo(snp.centerX)
		}
		contentLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(animationImageView)
			maker.bottom.equalTo(animationImageView.snp.top).offset(-10)
			maker.right.equalTo(animationLabel).offset(50)
		}
		nickNameLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(animationImageView)
			maker.bottom.equalTo(contentLabel.snp.top).offset(-10)
			maker.right.equalTo(animationLabel)
		}
		musicImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-5)
			maker.bottom.equalTo(animationImageView)
			maker.width.height.equalTo(50)
		}
		shareButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(musicImageView.snp.top).offset(-60)
			maker.centerX.equalTo(musicImageView)
		}
		replyButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(shareButton.snp.top).offset(-30)
			maker.centerX.equalTo(musicImageView)
		}
		likeButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(replyButton.snp.top).offset(-30)
			maker.centerX.equalTo(musicImageView)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(likeButton.snp.top).offset(-45)
			maker.centerX.equalTo(musicImageView)
			maker.width.height.equalTo(49)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(headImageView.snp.bottom)
			maker.centerX.equalTo(musicImageView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTVideoContentModel else {
			return
		}
		backgroundImageView.kf.setImage(with: Request.url(model.imageurl), placeholder: Request.placeImage)
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		likeButton.setTitle("\(model.likenum)", for: .normal)
		replyButton.setTitle("\(model.replynum)", for: .normal)
		shareButton.setTitle("\(model.sharenum)", for: .normal)
		nickNameLabel.text = model.nickname
		contentLabel.text = model.video_title
		animationLabel.text = "@" + model.nickname + "创作的原声"
	}

}

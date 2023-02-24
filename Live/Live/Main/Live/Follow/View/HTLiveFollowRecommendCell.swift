//
//  HTLiveFollowRecommendCell.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveFollowRecommendCell: UICollectionViewCell, ReuseCell {

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 3
		return imageView
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()

	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(101), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(101), for: .horizontal)
		return label
	}()

	lazy var visitCountButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "a69be4d561d184a8a4cff32da72303b2"), for: .normal)
		button.setContentHuggingPriority(UILayoutPriority.init(102), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(102), for: .horizontal)
		button.contentHorizontalAlignment = .left
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 5)
		return button
	}()

	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("关注", for: .normal)
		button.setTitle("已关注", for: .selected)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 1, green: 0.3, blue: 0.48, alpha: 1)), for: .normal)
		button.setBackgroundImage(UIImage.from(UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)), for: .selected)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13)
		button.layer.masksToBounds = true
		return button
	}()

	lazy var separatorView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		return view
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		followButton.layer.cornerRadius = followButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(headImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		contentView.addSubview(visitCountButton)
		addSubview(followButton)
		contentView.addSubview(separatorView)
		headImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(10)
			maker.left.equalTo(10)
			maker.bottom.equalTo(-10)
			maker.width.equalTo(headImageView.snp.height)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.top.equalTo(headImageView).offset(10)
			maker.right.equalTo(followButton.snp.left).offset(-20)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleLabel.snp.bottom).offset(15)
			maker.right.equalTo(followButton.snp.left).offset(-20)
		}
		visitCountButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView).offset(-10)
			maker.right.equalTo(followButton.snp.left).offset(-10)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(headImageView)
		}
		separatorView.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.right.equalTo(0)
			maker.bottom.equalTo(0)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func reloadFollowButtonWithModel(_ model: Any?) {
		guard let model = model as? HTLiveContentModel else {
			return
		}
		followButton.isSelected = model.isfollow == 1
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveContentModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.phonehallposter), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 14)
			let attributedString = NSMutableAttributedString.init()
			var image = UIImage.init(named: "level_\(model.creditLevel)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5))
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: font,
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]))
			return attributedString
		}()
		detailLabel.text = model.publicnotice.count > 0 ? model.publicnotice : "主播啥也没写..."
		visitCountButton.setTitle("\(model.usercount)", for: .normal)

		reloadFollowButtonWithModel(model)
		followButton.whenTouch(inside: { [weak self] (_, _) in
			if model.isfollow != 1 {
				Request.action.userFollow(model.uid, { (result) in
					guard let _ = result.value else {
						return
					}
					HTHud.showSuccess(withStatus: "关注成功 !")
					model.isfollow = 1
					self?.reloadFollowButtonWithModel(model)
				})
			} else {
				Request.action.userFollowCancel(model.uid, { (result) in
					guard let _ = result.value else {
						return
					}
					HTHud.showSuccess(withStatus: "取消关注成功 !")
					model.isfollow = 0
					self?.reloadFollowButtonWithModel(model)
				})
			}
		}, receive: nil)
	}
    
}

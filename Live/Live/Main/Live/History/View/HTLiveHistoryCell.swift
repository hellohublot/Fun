//
//  HTLiveHistoryCell.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import Kingfisher
import HTSwift

class HTLiveHistoryCell: UITableViewCell, ReuseCell {

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

	lazy var visitTimeLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(102), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(102), for: .horizontal)
		return label
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

	lazy var liveStateButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setTitleColor(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1), for: .selected)
		button.setTitle("未开播", for: .normal)
		button.setTitle("直播中", for: .selected)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 3)
		button.isUserInteractionEnabled = false
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

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		backgroundColor = UIColor.clear

		contentView.addSubview(headImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		contentView.addSubview(visitTimeLabel)
		addSubview(followButton)
		contentView.addSubview(liveStateButton)
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
			maker.right.equalTo(liveStateButton.snp.left).offset(-20)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleLabel.snp.bottom).offset(10)
			maker.right.equalTo(liveStateButton.snp.left).offset(-20)
		}
		visitTimeLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView).offset(-5)
			maker.right.equalTo(liveStateButton.snp.left).offset(-10)
		}
		liveStateButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(visitTimeLabel)
			maker.right.equalTo(followButton)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.bottom.equalTo(liveStateButton.snp.top).offset(-15)
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
		guard let model = model as? HTLiveHistoryModel else {
			return
		}
		followButton.isSelected = model.issubscribe
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveHistoryModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 14)
			let attributedString = NSMutableAttributedString.init()
			var image = UIImage.init(named: "level_\(model.creditlevel)_33x14_") ?? UIImage()
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
		detailLabel.text = model.publicnotice.count > 0 ? model.publicnotice : "这个人很懒, 什么也没留下"

		var visitDateString = model.seeDate
		let dateFormatter = DateFormatter.init()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: visitDateString) ?? Date()
		let calendarComponents = Calendar.current.dateComponents([.day], from: date, to: Date())
		if calendarComponents.day == 0 {
			visitDateString = ""
		} else if calendarComponents.day == 1 {
			visitDateString = "昨天"
		}


		visitTimeLabel.text = "\(visitDateString) \(model.seeTime)"

		liveStateButton.isSelected = model.status == "1"
		let normalImage = UIImage.init(named: "480f9031a180b75cbc3208dd90f62620")
		if liveStateButton.isSelected == false {
			liveStateButton.setImage(normalImage, for: .normal)
		} else {
			let imageModifier = AnyImageModifier.init(modify: { (fromImage) -> UIImage in
				let imageList = fromImage.images?.map({ (image) -> UIImage in
					let scale = (normalImage?.size.width ?? 1) / image.size.width
					return image.imageWith(zoom: scale)
				}) ?? [UIImage]()
				let toImage = UIImage.animatedImage(with: imageList, duration: fromImage.duration) ?? UIImage()
				return toImage
			})
			liveStateButton.kf.setImage(with: URL.init(fileURLWithPath: Bundle.main.path(forAuxiliaryExecutable: "3cbece1e4aef49d2640cbeb1dd68a5d3.gif") ?? ""), for: .normal, options: [.imageModifier(imageModifier), .preloadAllAnimationData])
		}

		reloadFollowButtonWithModel(model)
		followButton.whenTouch(inside: { [weak self] (_, _) in
			if model.issubscribe == false {
				Request.action.userFollow(model.artistuid, { (result) in
					guard let _ = result.value else {
						return
					}
					HTHud.showSuccess(withStatus: "关注成功 !")
					model.issubscribe = true
					self?.reloadFollowButtonWithModel(model)
				})
			} else {
				Request.action.userFollowCancel(model.artistuid, { (result) in
					guard let _ = result.value else {
						return
					}
					HTHud.showSuccess(withStatus: "取消关注成功 !")
					model.issubscribe = false
					self?.reloadFollowButtonWithModel(model)
				})
			}
		}, receive: nil)

	}


}

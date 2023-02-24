//
//  HTDiscoverRankContentNormalCell.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverRankContentNormalCell: UICollectionViewCell, ReuseCell {
	
	lazy var rankIndexButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 1, left: 3, bottom: 1, right: 3)
		button.layer.cornerRadius = 2
		button.layer.masksToBounds = true
		return button
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
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
	
	lazy var pkScoreLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 2
		return label
	}()
	
	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.from(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)), for: .normal)
        button.setBackgroundImage(UIImage.from(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), for: .disabled)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13)
		button.setTitle("关注", for: .normal)
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
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		followButton.layer.cornerRadius = followButton.bounds.size.height / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(rankIndexButton)
		addSubview(headImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(detailLabel)
		addSubview(followButton)
		contentView.addSubview(pkScoreLabel)
		contentView.addSubview(separatorView)
		rankIndexButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(8)
			maker.centerY.equalTo(contentView)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(contentView)
			maker.left.equalTo(rankIndexButton.snp.right).offset(8)
			maker.width.height.equalTo(40)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.top.equalTo(headImageView).offset(3)
			maker.right.equalTo(followButton.snp.left).offset(-10)
			maker.right.equalTo(pkScoreLabel.snp.left).offset(-20)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleLabel.snp.bottom).offset(10)
			maker.right.equalTo(followButton.snp.left).offset(-10)
			maker.right.equalTo(pkScoreLabel.snp.left).offset(-20)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(contentView)
		}
		pkScoreLabel.snp.makeConstraints { (maker) in
			maker.right.equalTo(-25)
			maker.centerY.equalTo(contentView)
		}
		separatorView.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.right.equalTo(0)
			maker.top.equalTo(0)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverRankContentModel else {
			return
		}
		rankIndexButton.setTitle("\(indexPath.row + 4)", for: .normal)
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let font = UIFont.systemFont(ofSize: 14)
			switch model.pageType {
			case .star?:
				var image = UIImage.init(named: "level_\(model.creditlevel)_33x14_") ?? UIImage()
				image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5))
				let attachment = NSTextAttachment.init()
				attachment.image = image
				attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
				attributedString.append(NSAttributedString.init(attachment: attachment))
			case .charm?:
				attributedString.append(NSAttributedString.init(string: model.badgeTitle, attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
				]))
				var image = UIImage.from(UIColor.clear)
				image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10))
				let attachment = NSTextAttachment.init()
				attachment.image = image
				attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
				attributedString.append(NSAttributedString.init(attachment: attachment))
			default:
				break
			}
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: font,
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]))
			return attributedString
		}()
		pkScoreLabel.isHidden = true
		followButton.isHidden = false
		pkScoreLabel.attributedText = nil
		switch model.pageType {
		case .star?:
			detailLabel.text = "靓号: \(model.uid)"
		case .rich?:
			detailLabel.text = "(ID: \(model.uid))"
		case .pk?:
			detailLabel.text = "(ID: \(model.uid))"
			pkScoreLabel.isHidden = false
			followButton.isHidden = true
			pkScoreLabel.attributedText = {
				let attributedString = NSMutableAttributedString.init()
				let paragraphStyle = NSMutableParagraphStyle.init()
				paragraphStyle.lineSpacing = 8
				paragraphStyle.alignment = .center
				attributedString.append(NSAttributedString.init(string: "贡献值: \(model.totalprice)", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
					.paragraphStyle: paragraphStyle
				]))
				attributedString.append(NSAttributedString.init(string: "\n胜利值: \(model.value) 场", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
					.paragraphStyle: paragraphStyle
				]))
				return attributedString
			}()
		case .charm?:
			detailLabel.text = "魅力值: \(model.value)"
		default:
			break
		}
        
        reloadFollowButtonWithModel(model)
        followButton.whenTouch(inside: { [weak self] (_, _) in
            Request.action.rankFollowUser("\(model.uid)", { (result) in
                guard let _ = result.value else {
                    return
                }
                model.isFollowed = true
                self?.reloadFollowButtonWithModel(model)
            })
        }, receive: nil)
        
	}
    
    func reloadFollowButtonWithModel(_ model: Any?) {
        guard let model = model as? HTDiscoverRankContentModel else {
            return
        }
        followButton.isEnabled = !model.isFollowed
        followButton.isUserInteractionEnabled = followButton.isEnabled
    }
    
}

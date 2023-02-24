//
//  HTMineGuardManagerCell.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import Kingfisher

class HTMineGuardManagerCell: UITableViewCell, ReuseCell {
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
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
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(visitCountButton)
		addSubview(liveStateButton)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(50)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.top.equalTo(headImageView).offset(5)
		}
		visitCountButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.top.equalTo(titleLabel.snp.bottom).offset(20)
		}
		liveStateButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-15)
			maker.centerY.equalTo(visitCountButton)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineGuardManagerModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 14)
			let attributedString = NSMutableAttributedString.init()
			var image = UIImage.init(named: "level_\(model.wealth_level)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5))
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: font,
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
			]))
			if model.status == 1 {
				attributedString.append(NSAttributedString.init(string: "  (已开播: \(model.timestr))", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
				]))
			}
			return attributedString
		}()
		visitCountButton.setTitle(model.follownum, for: .normal)
		
		liveStateButton.isSelected = model.status == 1
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

		
	}

}

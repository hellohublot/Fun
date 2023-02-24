//
//  HTMineStorePolicyDetailCell.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyDetailCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()
	
	lazy var flagButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "9fc67255d05acc75bbcf0b9ee5cd1656"), for: .normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(titleLabel)
		addSubview(flagButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.centerY.equalTo(self)
		}
		flagButton.snp.makeConstraints { (maker) in
			maker.right.bottom.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStorePolicyDetailModel else {
			return
		}
		titleLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .center
			
			let image = UIImage.init(named: model.image ?? "")
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.title ?? ""), attributes: [
				.font: UIFont.boldSystemFont(ofSize: 14),
				.foregroundColor: UIColor.init(red: 0.13, green: 0.13, blue: 0.13, alpha: 1),
			]))
			
			paragraphStyle.lineSpacing = 8
			attributedString.addAttributes([
				.paragraphStyle: paragraphStyle,
			], range: NSRange.init(location: 0, length: attributedString.length))
			
			attributedString.append(NSAttributedString.init(string: "\n" + (model.title ?? ""), attributes: [
				.font: UIFont.boldSystemFont(ofSize: 13),
				.foregroundColor: UIColor.init(red: 0.73, green: 0.73, blue: 0.73, alpha: 1),
			]))
			
			paragraphStyle.lineSpacing = 3
			attributedString.addAttributes([
				.paragraphStyle: paragraphStyle,
			], range: NSRange.init(location: 0, length: attributedString.length))
			return attributedString
		}()
	}
    
}

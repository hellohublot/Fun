//
//  HTMineRechargeCell.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineRechargeCell: UICollectionViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		label.layer.cornerRadius = 3
		label.layer.borderWidth = 1 / UIScreen.main.scale
		label.layer.masksToBounds = true
		return label
	}()

	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "77c3420517193f59bf5ecb8ab7a6d45f")
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		addSubview(flagImageView)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.bottom.right.equalTo(0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineRechargeModel else {
			return
		}
		titleLabel.layer.borderColor = (model.selected ?? false) ? UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1).cgColor : UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
		titleLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.lineSpacing = 15
			paragraphStyle.alignment = .center
			attributedString.append(NSAttributedString.init(string: model.title ?? "", attributes: [
				.font: UIFont.systemFont(ofSize: 14),
				.foregroundColor: (model.selected ?? false) ? UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1) : UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.text ?? ""), attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: (model.selected ?? false) ? UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1) : UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
		flagImageView.isHidden = !(model.selected ?? false)
	}
    
}

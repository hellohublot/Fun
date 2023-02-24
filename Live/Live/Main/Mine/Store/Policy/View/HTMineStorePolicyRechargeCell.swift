//
//  HTMineStorePolicyRechargeCell.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyRechargeCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()
	
	lazy var headTitleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
		button.setTitleColor(UIColor.init(red: 0.64, green: 0.28, blue: 0.11, alpha: 1), for: .normal)
		button.setBackgroundImage(UIImage.init(named: "4a5ea4a3baae18b2324d08ad2978a592"), for: .normal)
		return button
	}()
	
	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "8701498c38fa32ee9538613c0c978831")
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.layer.cornerRadius = 8
		contentView.layer.borderWidth = 1
		addSubview(titleLabel)
		addSubview(flagImageView)
		addSubview(headTitleButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.centerY.equalTo(self)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.bottom.right.equalTo(0)
		}
		headTitleButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(snp.top)
			maker.centerX.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStorePolicyRechargeModel else {
			return
		}
		titleLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: model.title ?? "", attributes: [
				.font: UIFont.boldSystemFont(ofSize: 15),
				.foregroundColor: UIColor.init(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
				]))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.buyCoin ?? ""), attributes: [
				.font: UIFont.boldSystemFont(ofSize: 17),
				.foregroundColor: (model.selected ?? false) ? UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1) : UIColor.init(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
				]))
			attributedString.append(NSAttributedString.init(string: "\n" + (model.payMoney ?? ""), attributes: [
				.font: UIFont.boldSystemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
				]))
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.lineSpacing = 8
			paragraphStyle.alignment = .center
			attributedString.addAttributes([
				.paragraphStyle: paragraphStyle
				], range: NSRange.init(location: 0, length: attributedString.length))
			return attributedString
		}()
		contentView.backgroundColor = (model.selected ?? false) ? UIColor.init(red: 1, green: 0.984, blue: 0.984, alpha: 1) : UIColor.white
		contentView.layer.borderColor = (model.selected ?? false) ? UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1).cgColor : UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
		flagImageView.isHidden = !(model.selected ?? false)
		headTitleButton.setTitle( (model.selected ?? false) ? "赠送15天" : "", for: .normal)
		headTitleButton.isHidden = (headTitleButton.currentTitle?.count ?? 0) <= 0
	}
    
}

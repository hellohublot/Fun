//
//  HTMineStoreVIPRechargeCell.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreVIPRechargeCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 8
		layer.borderWidth = 1
		layer.masksToBounds = true
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreVIPRechargeModel else {
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
		backgroundColor = (model.selected ?? false) ? UIColor.init(red: 1, green: 0.984, blue: 0.984, alpha: 1) : UIColor.white
		layer.borderColor = (model.selected ?? false) ? UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1).cgColor : UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
		
	}

}

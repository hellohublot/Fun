//
//  HTMineLoveFooterView.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTMineLoveFooterView: UIView {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		label.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .left
			paragraphStyle.lineSpacing = 8
			attributedString.append(NSAttributedString.init(string: "1.佩戴TA的粉丝徽章后，将在其他直播间聊天区展示，为TA代言\n2.在真爱团的直播间中，默认会展示该主播的团徽章", attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(20)
			maker.left.equalTo(15)
			maker.right.equalTo(-15)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

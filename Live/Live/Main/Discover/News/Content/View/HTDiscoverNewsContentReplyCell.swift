//
//  HTDiscoverNewsContentReplyCell.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentReplyCell: UITableViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10))
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentReplyModel else {
			return
		}
		titleLabel.attributedText = model.replyContentAttributedString
	}

}

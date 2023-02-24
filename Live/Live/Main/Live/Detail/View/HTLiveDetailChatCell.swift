//
//  HTLiveDetailChatCell.swift
//  Live
//
//  Created by hublot on 2019/1/7.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveDetailChatCell: UITableViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 13)
		label.textColor = UIColor.init(red: 1, green: 0.945098, blue: 0.0705882, alpha: 1)
		label.numberOfLines = 0
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		contentView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10))
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveDetailChatModel, let nickname = model.msgbody?.srcnickname, nickname.count > 0, let content = model.msgbody?.content, content.count > 0 else {
			return
		}
		titleLabel.text = "\(nickname): \(content)"
	}

}

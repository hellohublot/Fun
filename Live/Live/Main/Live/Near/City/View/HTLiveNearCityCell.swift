//
//  HTLiveNearCityCell.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveNearCityCell: UITableViewCell, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.black
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveNearCityModel else {
			return
		}
		titleLabel.text = model.title
	}

}

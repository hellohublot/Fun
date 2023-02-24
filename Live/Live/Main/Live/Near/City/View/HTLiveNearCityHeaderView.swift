//
//  HTLiveNearCityHeaderView.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveNearCityHeaderView: UITableViewHeaderFooterView, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.textColor = UIColor.init(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
		return label
	}()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		backgroundView = UIImageView.init(image: UIImage.from(UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)))
		backgroundView?.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveNearCitySectionModel else {
			return
		}
		titleLabel.text = model.title
	}

}

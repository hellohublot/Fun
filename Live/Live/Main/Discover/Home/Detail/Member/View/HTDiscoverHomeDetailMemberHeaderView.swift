//
//  HTDiscoverHomeDetailMemberHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailMemberHeaderView: UITableViewHeaderFooterView, ReuseCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		return label
	}()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		backgroundView = UIImageView.init(image: UIImage.from(UIColor.white))
		backgroundView?.backgroundColor = UIColor.white
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-10)
			maker.left.equalTo(15)
			maker.right.equalTo(-15)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverHomeDetailMemberSectionModel else {
			return
		}
		titleLabel.text = model.title
	}


}

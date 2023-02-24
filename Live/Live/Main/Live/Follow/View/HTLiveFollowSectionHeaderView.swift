//
//  HTLiveFollowSectionHeaderView.swift
//  Live
//
//  Created by hublot on 2018/12/29.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveFollowSectionHeaderView: UICollectionReusableView, ReuseCell {

	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 10)
		button.contentHorizontalAlignment = .left
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		button.isUserInteractionEnabled = false
		return button
	}()

	lazy var detailButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
		button.setImage(UIImage.init(named: "3bf3cb5370d39e6f70e8128f705b4462"), for: .normal)
		button.setTitle("查看全部", for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: -5)
        button.whenTouch(inside: { [weak self] (_, _) in
            let followController = HTMineUserFollowRadioController()
            followController.navigationItem.title = "全部关注"
            Appdelegate.navigationController()?.pushViewController(followController, animated: true)
        })
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(titleButton)
		addSubview(detailButton)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(12)
			maker.centerY.equalTo(self)
			maker.right.equalTo(detailButton.snp.left).offset(-10)
		}
		detailButton.snp.makeConstraints { (maker) in
			maker.right.equalTo(-12)
			maker.centerY.equalTo(self)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTLiveFollowSectionModel else {
			return
		}
		titleButton.setImage(UIImage.init(named: model.image ?? ""), for: .normal)
		titleButton.setTitle(model.title, for: .normal)
        detailButton.isHidden = !model.showDetailButton
	}
        
}

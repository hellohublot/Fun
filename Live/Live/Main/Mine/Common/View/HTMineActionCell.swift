//
//  HTMineActionCell.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineActionCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		button.contentHorizontalAlignment = .left
		button.isUserInteractionEnabled = false
		button.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		button.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return button
	}()

	lazy var detailLaebl: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.92, green: 0.24, blue: 0.33, alpha: 1)
		label.textAlignment = .right
		return label
	}()

	lazy var switchControl: UISwitch = {
		let switchControl = UISwitch.init(frame: CGRect.zero)
		switchControl.onTintColor = UIColor.init(red: 1, green: 0.39, blue: 0.52, alpha: 1)
		return switchControl
	}()
	
	lazy var accessoryImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "fd3f224387d8149c6218be5086fdc844")
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(titleButton)
		contentView.addSubview(switchControl)
		contentView.addSubview(detailLaebl)
		contentView.addSubview(accessoryImageView)
		titleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(24)
			maker.top.bottom.equalTo(contentView)
		}
		detailLaebl.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(contentView)
			maker.left.equalTo(titleButton.snp.right).offset(15)
		}
		switchControl.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(contentView)
			maker.right.equalTo(-28)
		}
		accessoryImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-28)
			maker.centerY.equalTo(contentView)
			maker.left.equalTo(detailLaebl.snp.right).offset(10)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineActionModel else {
			return
		}
		titleButton.setImage(UIImage.init(named: model.image ?? ""), for: .normal)
		titleButton.setTitle(model.title, for: .normal)
		switchControl.isOn = model.selected ?? false
		detailLaebl.text = model.text
		if model.showSwitchControl == true {
			accessoryImageView.isHidden = true
			switchControl.isHidden = false
			accessoryImageView.snp.updateConstraints { (maker) in
				maker.right.equalTo(-70)
			}
		} else {
			accessoryImageView.isHidden = false
			switchControl.isHidden = true
			accessoryImageView.snp.updateConstraints { (maker) in
				maker.right.equalTo(-28)
			}
		}
	}
    
}

//
//  HTVideoPageHeaderCell.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoPageHeaderCell: UICollectionViewCell, ReuseCell {
	
	static let titleFont = UIFont.boldSystemFont(ofSize: 17)
	
	lazy var titleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = type(of: self).titleFont
		button.setTitleColor(UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1), for: .normal)
		button.setTitleColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
		button.isUserInteractionEnabled = false
		return button
	}()
	
	lazy var separatorLine: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.white
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(titleButton)
		contentView.addSubview(separatorLine)
		separatorLine.snp.makeConstraints { (maker) in
			maker.left.equalTo(0)
			maker.width.equalTo(2)
			maker.height.equalTo(5)
			maker.centerY.equalTo(contentView)
		}
		titleButton.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTPageModelAble else {
			return
		}
		separatorLine.isHidden = indexPath.row == 0
		titleButton.setTitle(model.title, for: .normal)
		titleButton.isSelected = model.selected ?? false
	}
    
}

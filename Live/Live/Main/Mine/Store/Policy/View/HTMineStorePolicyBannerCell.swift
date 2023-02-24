//
//  HTMineStorePolicyBannerCell.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStorePolicyBannerCell: UICollectionViewCell, ReuseCell {
	
	var modelArray = [HTMineStorePolicyBannerModel]()
	
	var buttonList = [UIButton]()
	
	lazy var buttonContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "dc50ccd00d90a21a833c784d2469538f")
		return imageView
	}()
	
	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "e1d3ceaa72b78d9e8215c28390d46fb5")
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(buttonContentView)
		addSubview(flagImageView)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		buttonContentView.snp.makeConstraints { (maker) in
			maker.top.equalTo(15)
			maker.left.right.equalTo(0)
			maker.bottom.equalTo(flagImageView.snp.top).offset(-5)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? [HTMineStorePolicyBannerModel], model != modelArray else {
			return
		}
		modelArray = model
		let count = modelArray.count
		for (index, model) in modelArray.enumerated() {
			let button = UIButton.init(frame: CGRect.zero)
			let image = UIImage.init(named: model.image ?? "")
			let darkImage = UIImage.from(UIColor.init(white: 0, alpha: 0.2)).imageWith(size: image?.size ?? CGSize.zero)
			button.setImage(image, for: .selected)
			button.setImage(image?.imageAppend(darkImage, at: CGPoint.zero), for: .normal)
			button.isSelected = model.selected ?? false
			let lastView = buttonContentView.subviews.last
			buttonContentView.addSubview(button)
			button.snp.makeConstraints { (maker) in
				if let lastView = lastView {
					maker.left.equalTo(lastView.snp.right)
					maker.width.equalTo(lastView)
					if index == count - 1 {
						maker.right.equalTo(0)
					}
				} else {
					maker.left.equalTo(0)
				}
			}
			if button.isSelected {
				flagImageView.snp.remakeConstraints({ (maker) in
					maker.bottom.equalTo(0)
					maker.centerX.equalTo(button)
				})
			}
//			button.whenTouch(inside: { [weak self] (_, _) in
//				
//			})
		}
	}
    
}

//
//  HTMineStoreSeatPageCell.swift
//  Live
//
//  Created by hublot on 2019/1/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreSeatCell: UICollectionViewCell, ReuseCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		label.textAlignment = .center
		return label
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.setContentHuggingPriority(UILayoutPriority.init(100), for: .vertical)
		imageView.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .vertical)
		return imageView
	}()
	
	lazy var moneyButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.black, for: .normal)
		button.setImage(UIImage.init(named: "9c9d34591dc0c7321cdfc028adf3fc32"), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 10)
		return button
	}()
	
	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor,
		]
		return gradientLayer
	}()
	
	lazy var payButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("购买", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		payButton.layer.cornerRadius = payButton.bounds.size.height / 2.0
		gradientLayer.frame = payButton.bounds
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.cornerRadius = 5
		
		backgroundColor = UIColor.white
		layer.shadowColor = UIColor.init(red: 0.109804, green: 0.160784, blue: 0.372549, alpha: 1).cgColor
		layer.shadowOpacity = 0.11
		layer.shadowRadius = 12
		layer.shadowOffset = CGSize.init(width: 0, height: 3)
		layer.borderWidth = 1 / UIScreen.main.scale
		layer.borderColor = UIColor.init(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1).cgColor
		
		addSubview(titleLabel)
		addSubview(headImageView)
		addSubview(moneyButton)
		addSubview(payButton)
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(15)
			maker.left.equalTo(5)
			maker.right.equalTo(-5)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(0)
			maker.right.equalTo(0)
			maker.top.equalTo(titleLabel.snp.bottom).offset(20)
		}
		moneyButton.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(self)
			maker.top.equalTo(headImageView.snp.bottom).offset(10)
		}
		payButton.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(self)
			maker.width.equalTo(95)
			maker.height.equalTo(23)
			maker.top.equalTo(moneyButton.snp.bottom).offset(10)
			maker.bottom.equalTo(-15)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreSeatModel else {
			return
		}
		titleLabel.text = model.name
		headImageView.kf.setImage(with: Request.url(model.imgurl), placeholder: Request.placeImage)
		moneyButton.setTitle("\(model.year_price)九币/月", for: .normal)
	}
    
}

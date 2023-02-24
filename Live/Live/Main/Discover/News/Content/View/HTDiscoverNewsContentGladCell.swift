//
//  HTDiscoverNewsContentGladCell.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentGladCell: UITableViewCell, ReuseCell {
	
	lazy var gladContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		return view
	}()
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true		
		return imageView
	}()
	
	lazy var flagImageView: UIImageView = {
		let flagImageView = UIImageView.init(frame: CGRect.zero)
		flagImageView.image = UIImage.init(named: "f4e32dd94711eca385f38680e465a33b")
		return flagImageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		return label
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		addSubview(gladContentView)
		addSubview(headImageView)
		addSubview(flagImageView)
		addSubview(titleLabel)
		gladContentView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10))
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(gladContentView).offset(20)
			maker.top.equalTo(gladContentView).offset(10)
			maker.width.height.equalTo(40)
		}
		flagImageView.snp.makeConstraints({ (maker) in
			maker.centerX.equalTo(headImageView)
			maker.bottom.equalTo(headImageView).offset(15)
		})
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(20)
			maker.right.equalTo(gladContentView.snp.right).offset(-10)
			maker.centerY.equalTo(gladContentView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.info?.headimage), placeholder: Request.placeImage)
		titleLabel.text = model.gladContent
	}

}

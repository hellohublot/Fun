//
//  HTMineUserCell.swift
//  Live
//
//  Created by hublot on 2018/12/28.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserCell: UICollectionViewCell, ReuseCell {
	
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var fansLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(101), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(101), for: .horizontal)
		return label
	}()
	
	lazy var followLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
		label.setContentHuggingPriority(UILayoutPriority.init(100), for: .horizontal)
		label.setContentCompressionResistancePriority(UILayoutPriority.init(100), for: .horizontal)
		return label
	}()
	
	lazy var accessoryImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "ee6acc7ed29dcbaa0a2244316678e877")
		return imageView
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.width / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(fansLabel)
		addSubview(followLabel)
		addSubview(accessoryImageView)
		headImageView.snp.makeConstraints { (maker) in
			maker.left.equalTo(36)
			maker.centerY.equalTo(self)
			maker.width.height.equalTo(63)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(headImageView.snp.right).offset(12)
			maker.top.equalTo(headImageView).offset(5)
			maker.right.equalTo(accessoryImageView.snp.left).offset(-10)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.centerY.equalTo(headImageView).offset(2.5)
			maker.right.equalTo(accessoryImageView.snp.left).offset(-10)
		}
		fansLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(titleLabel)
			maker.bottom.equalTo(headImageView)
		}
		followLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(fansLabel.snp.right)
			maker.centerY.equalTo(fansLabel)
			maker.right.equalTo(accessoryImageView.snp.left).offset(-10)
		}
		accessoryImageView.snp.makeConstraints { (maker) in
			maker.right.equalTo(-28)
			maker.centerY.equalTo(self)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineUserInfoModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: UIImage.init(named: "6c730a28240e22a755827fbc4a8a8338"))
		if HTUserAuthManager.isLogin() {
            titleLabel.whenTouch(inside: { (_, _) in
                HTSetupNicknameController.show()
            }, receive: nil)
            fansLabel.whenTouch(inside: { [weak self] (_, _) in
                let fansController = HTMineUserFansController()
                fansController.uidString = model.uid
                self?.controller?.navigationController?.pushViewController(fansController, animated: true)
            }, receive: nil)
            followLabel.whenTouch(inside: { [weak self] (_, _) in
                let followController = HTMineUserFollowController()
                followController.uidString = model.uid
                self?.controller?.navigationController?.pushViewController(followController, animated: true)
            }, receive: nil)
            
            
			titleLabel.attributedText = NSAttributedString.init(string: model.nickname, attributes: [
				.font: UIFont.boldSystemFont(ofSize: 16),
				.foregroundColor: UIColor.init(red: 0.286275, green: 0.286275, blue: 0.286275, alpha: 1)
			])
			detailLabel.text = "ID:\(model.uid)"
			fansLabel.text = "\(model.fansNum) 粉丝  "
			followLabel.text = "I  \(model.followNum) 关注"
		} else {
            titleLabel.isUserInteractionEnabled = false
            fansLabel.isUserInteractionEnabled = false
            followLabel.isUserInteractionEnabled = false
            
            
			titleLabel.attributedText = NSAttributedString.init(string: "登录/注册", attributes: [
				.font: UIFont.boldSystemFont(ofSize: 15),
				.foregroundColor: UIColor.init(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
			])
			detailLabel.text = ""
			fansLabel.text = "精彩从此呈现"
			followLabel.text = ""
		}
	}
    
}

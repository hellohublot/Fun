//
//  HTDiscoverRankContentHeaderCell.swift
//  Live
//
//  Created by hublot on 2019/1/14.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverRankContentHeaderCell: UICollectionViewCell, ReuseCell {
	
	lazy var headTopImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
    
	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderWidth = 1
		return imageView
	}()
	
	lazy var headBottomImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var pkScoreLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 2
		return label
	}()
	
	lazy var followButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.from(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)), for: .normal)
        button.setBackgroundImage(UIImage.from(UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), for: .disabled)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13)
		button.setTitle("关注", for: .normal)
        button.setTitle("已关注", for: .disabled)
		button.layer.masksToBounds = true
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
		followButton.layer.cornerRadius = followButton.bounds.size.height / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(headImageView)
		addSubview(headTopImageView)
		addSubview(headBottomImageView)
		addSubview(titleLabel)
		addSubview(followButton)
		addSubview(pkScoreLabel)
		headImageView.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(self)
			maker.bottom.equalTo(titleLabel.snp.top).offset(-25)
			maker.height.equalTo(0)
			maker.width.equalTo(headImageView.snp.height)
		}
		headTopImageView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(headImageView.snp.top).offset(3)
			maker.centerX.equalTo(headImageView)
		}
		headBottomImageView.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView.snp.bottom).offset(-10)
			maker.centerX.equalTo(headImageView)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.right.equalTo(-5)
			maker.bottom.equalTo(pkScoreLabel.snp.top).offset(-5)
		}
		pkScoreLabel.snp.makeConstraints { (maker) in
			maker.left.equalTo(5)
			maker.right.equalTo(-5)
			maker.bottom.equalTo(followButton.snp.top).offset(-5)
		}
		followButton.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(self)
			maker.bottom.equalTo(-20)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverRankContentModel else {
			return
		}
		guard model.placeHolder == false else {
			isHidden = true
			return
		}
		isHidden = false
		
		
		
		var headerTopImage = ""
		var headerBottomImage = ""
		var borderColor = UIColor.clear
		var headImageHeight = 0
		
		switch indexPath.row {
		case 0:
			borderColor = UIColor.init(red: 0.63, green: 0.67, blue: 0.91, alpha: 1)
			headImageHeight = 58
			headerTopImage = "6ae6aa451a734505adf1f1446d9d2a80"
			headerBottomImage = "ccff4fd8e5013dd6085dfbd4f9abbc58"
		case 1:
			borderColor = UIColor.init(red: 1, green: 0.69, blue: 0.16, alpha: 1)
			headImageHeight = 68
			headerTopImage = "3ebabce24910fc9c41f6dd581a0a8231"
			headerBottomImage = "bbb6ce6b898d24e765d1ac8f639438c5"
		case 2:
			borderColor = UIColor.init(red: 0.96, green: 0.61, blue: 0.41, alpha: 1)
			headImageHeight = 58
			headerTopImage = "29cf68d089cebb634827fd76ab24971b"
			headerBottomImage = "4cb6a34460ba3a5724772052994f38d7"
		default:
			break
		}
		headTopImageView.image = UIImage.init(named: headerTopImage)
		headBottomImageView.image = UIImage.init(named: headerBottomImage)
		headImageView.snp.updateConstraints { (maker) in
			maker.height.equalTo(headImageHeight)
		}
		headImageView.layer.borderColor = borderColor.cgColor
		headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .center
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: UIFont.systemFont(ofSize: 14),
				.foregroundColor: borderColor,
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
		
		
		pkScoreLabel.isHidden = true
		followButton.isHidden = false
		pkScoreLabel.attributedText = nil
		pkScoreLabel.snp.updateConstraints { (maker) in
			maker.bottom.equalTo(followButton.snp.top).offset(-5)
		}
		switch model.pageType {
		case .pk?:
			pkScoreLabel.isHidden = false
			followButton.isHidden = true
			pkScoreLabel.snp.updateConstraints { (maker) in
				maker.bottom.equalTo(followButton.snp.top).offset(30)
			}
			pkScoreLabel.attributedText = {
				let attributedString = NSMutableAttributedString.init()
				let paragraphStyle = NSMutableParagraphStyle.init()
				paragraphStyle.lineSpacing = 8
				paragraphStyle.alignment = .center
				attributedString.append(NSAttributedString.init(string: "贡献值: \(model.totalprice)", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: borderColor,
					.paragraphStyle: paragraphStyle
				]))
				attributedString.append(NSAttributedString.init(string: "\n胜利值: \(model.value) 场", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: borderColor,
					.paragraphStyle: paragraphStyle
				]))
				return attributedString
			}()
		case .charm?:
			pkScoreLabel.isHidden = false
			pkScoreLabel.attributedText = {
				let attributedString = NSMutableAttributedString.init()
				let paragraphStyle = NSMutableParagraphStyle.init()
				paragraphStyle.alignment = .center
				attributedString.append(NSAttributedString.init(string: "魅力值: \(model.value)", attributes: [
					.font: UIFont.systemFont(ofSize: 12),
					.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
					.paragraphStyle: paragraphStyle
				]))
				return attributedString
			}()
		default:
			break
		}
        
        reloadFollowButtonWithModel(model)
        followButton.whenTouch(inside: { [weak self] (_, _) in
            Request.action.rankFollowUser("\(model.uid)", { (result) in
                guard let _ = result.value else {
                    return
                }
                model.isFollowed = true
                self?.reloadFollowButtonWithModel(model)
            })
        }, receive: nil)
        
		
	}
    
    func reloadFollowButtonWithModel(_ model: Any?) {
        guard let model = model as? HTDiscoverRankContentModel else {
            return
        }
        followButton.isEnabled = !model.isFollowed
        followButton.isUserInteractionEnabled = followButton.isEnabled
    }
	
}

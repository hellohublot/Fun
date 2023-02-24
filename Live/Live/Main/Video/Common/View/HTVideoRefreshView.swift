//
//  HTVideoRefreshView.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTVideoRefreshView: UIView {

	lazy var refreshImageView: UIImageView = {
		let refreshImageView = UIImageView.init(frame: CGRect.zero)
		refreshImageView.contentMode = .scaleAspectFill
		refreshImageView.layer.masksToBounds = true
		refreshImageView.image = UIImage.init(named: "3f3192db2f017ad5203f01a16c79d772")
		return refreshImageView
	}()
	
	@objc lazy var rotationAnimation: CABasicAnimation = {
		let animation = CABasicAnimation.init()
		animation.keyPath = "transform.rotation"
		animation.fromValue = 0
		animation.toValue = Double.pi * 2
		animation.duration = 0.5
		animation.fillMode = kCAFillModeForwards
		animation.repeatCount = Float(Int.max)
		animation.autoreverses = false
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
		animation.delegate = self
		return animation
	}()
	
	@objc lazy var scaleAnimation: CABasicAnimation = {
		let animation = CABasicAnimation.init()
		animation.keyPath = "transform.scale"
		animation.fromValue = 1
		animation.toValue = 0.5
		animation.duration = 0.15
		animation.fillMode = kCAFillModeForwards
		animation.repeatCount = 1
		animation.autoreverses = false
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
		animation.delegate = self
		return animation
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(refreshImageView)
		refreshImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	func setRefresh(_ refresh: Bool, animated: Bool) {
		if animated {
			rotationAnimation.duration = 0.5
			scaleAnimation.duration = 0.1
		} else {
			rotationAnimation.duration = 0
			scaleAnimation.duration = 0
		}
		if refresh == true {
			refreshImageView.layer.removeAnimation(forKey: NSStringFromSelector(#selector(getter: scaleAnimation)))
			refreshImageView.layer.add(rotationAnimation, forKey: NSStringFromSelector(#selector(getter: rotationAnimation)))
		} else {
			if let _ = refreshImageView.layer.animation(forKey: NSStringFromSelector(#selector(getter: scaleAnimation))) {
				return
			}
			refreshImageView.layer.add(scaleAnimation, forKey: NSStringFromSelector(#selector(getter: scaleAnimation)))
		}
	}
	
	override var intrinsicContentSize: CGSize {
		return refreshImageView.intrinsicContentSize
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension HTVideoRefreshView: CAAnimationDelegate {
	
	func animationDidStart(_ anim: CAAnimation) {
		if anim == refreshImageView.layer.animation(forKey: NSStringFromSelector(#selector(getter: rotationAnimation))) {
			refreshImageView.isHidden = false
		}
	}
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if anim == refreshImageView.layer.animation(forKey: NSStringFromSelector(#selector(getter: scaleAnimation))) {
			refreshImageView.isHidden = true
		}
	}
	
}

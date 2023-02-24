//
//  HTMusicPlayerRotateController.swift
//  Music163
//
//  Created by hublot on 2018/12/21.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class HTMusicPlayerRotateController: UIViewController {

	lazy var separatorLineView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(white: 1, alpha: 0.15)
		return view
	}()
	
	lazy var backgroundImageView: UIImageView = {
		let backgroundImageView = UIImageView.init(frame: CGRect.zero)
		backgroundImageView.contentMode = .scaleToFill
		backgroundImageView.layer.masksToBounds = true
		let centerImage = UIImage.init(named: HTStatic.isX ? "cm2_play_disc_mask-ipx" : "cm2_play_disc_mask-ip6")
//		backgroundImageView.image = centerImage

		return backgroundImageView
	}()

    func createEmitterCell(isLight: Bool) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.scaleSpeed = 0
        cell.scaleRange = 0.25
        cell.scale = 0.5
        cell.contents = UIImage.init(named: "emitter")?.cgImage
        cell.lifetime = 1.5
        cell.yAcceleration = 1
        cell.zAcceleration = 0
        cell.emissionRange = 0
        cell.birthRate = 1

        cell.alphaSpeed = isLight ? -0.533333 : -0.666667
        cell.velocityRange = isLight ? 5 : 10
        cell.velocity = isLight ? 5 : 15


        if (isLight) {
            cell.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
            cell.name = "lightRocket"
        } else {
            cell.color = UIColor.init(red: 1, green: 0.84, blue: 0.61, alpha: 1).cgColor
            cell.alphaRange = 1
            cell.redRange = 0
            cell.greenRange = 0
            cell.name = "rocket"
        }
        return cell

    }

    lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        emitterLayer.renderMode = kCAEmitterLayerAdditive
        emitterLayer.birthRate = 5000
        emitterLayer.emitterCells = [
            createEmitterCell(isLight: false),
            createEmitterCell(isLight: true),
        ]
        return emitterLayer
    }()

	lazy var contentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.masksToBounds = true
		return view
	}()
	
	lazy var rotateContentView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "ecc6314e2ccc40a9e4f69aec57dba483")
//		imageView.image = image
		return imageView
	}()
	
	lazy var userImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "012d9f51654a912ee92052ffd575a1b3")
		imageView.image = image
		
		let animation: CABasicAnimation = {
			let animation = CABasicAnimation.init(keyPath: "transform.rotation")
			animation.duration = 20
			animation.fromValue = 0
			animation.toValue = (360 / 180.0) * Double.pi
			animation.fillMode = kCAFillModeForwards
			animation.repeatCount = Float(Int.max)
			animation.autoreverses = false
			animation.isRemovedOnCompletion = false
			animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
			return animation
		}()
		imageView.layer.add(animation, forKey: nil)
		return imageView
	}()
	
	lazy var stylusImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		let image = UIImage.init(named: "622520edd0621e1fd6014c8d32f848c4")
		imageView.image = image
		imageView.sizeToFit()
		let anchorLeft: CGFloat = 29
		let anchorTop: CGFloat = 29
		imageView.layer.anchorPoint = CGPoint.init(x: anchorLeft / imageView.bounds.size.width, y: anchorTop / imageView.bounds.size.height)
		imageView.frame.origin = CGPoint.init(x: view.bounds.size.width / 2.0 - anchorLeft, y: -anchorTop)
		return imageView
	}()

	lazy var rotateActionBar: HTMusicPlayerRotateActionBar = {
		let rotateActionBar = HTMusicPlayerRotateActionBar.init(frame: CGRect.zero)
		return rotateActionBar
	}()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.layoutSubviews()
        emitterLayer.emitterSize = rotateContentView.bounds.size
        emitterLayer.emitterPosition = rotateContentView.center
    }
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource () {
		let player = HTMusicPlayer.share
		player.addObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: HTMusicPlayer.rate)), options: [.initial, .new], context: nil)
	}

	func initInterface() {
		view.addSubview(backgroundImageView)
		view.addSubview(separatorLineView)
		view.addSubview(contentView)
		view.addSubview(rotateActionBar)
		contentView.addSubview(rotateContentView)
		rotateContentView.addSubview(userImageView)
		contentView.addSubview(stylusImageView)
        contentView.layer.addSublayer(emitterLayer)

		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		separatorLineView.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.top.equalTo(HTStatic.navigationHeight)
			maker.height.equalTo(1 / UIScreen.main.scale)
		}
		contentView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.init(top: HTStatic.navigationHeight, left: 0, bottom: HTMusicPlayerControlBar.controlBarHeight + HTStatic.homeHeight, right: 0))
		}
		rotateActionBar.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(contentView)
			maker.left.right.equalTo(0)
			maker.height.equalTo(40)
		}
		rotateContentView.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(view)
            maker.top.equalTo(100)
			maker.width.height.equalTo(300)
		}
		let userImageHeight: CGFloat = 290
		userImageView.layer.cornerRadius = userImageHeight / 2.0
		userImageView.snp.makeConstraints { (maker) in
			maker.center.equalTo(rotateContentView)
			maker.width.height.equalTo(userImageHeight)
		}
	}
	
	func switchRotateWithPlayerState(_ playing: Bool, _ animated: Bool) {
		if playing {
			UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
				self.stylusImageView.transform = playing ? CGAffineTransform.identity : CGAffineTransform.init(rotationAngle: CGFloat((-30 / 180.0) * Double.pi))
			}) { (finished) in
				self.userImageView.layer.resumeAnimation(playing)
			}
		} else {
			userImageView.layer.resumeAnimation(playing)
			UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
				self.stylusImageView.transform = playing ? CGAffineTransform.identity : CGAffineTransform.init(rotationAngle: CGFloat((-30 / 180.0) * Double.pi))
			}) { (finished) in
			}
		}
	}
	
	
	
	/*-------------------------------------/ controller override /-----------------------------------*/

	deinit {
		HTMusicPlayer.share.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: HTMusicPlayer.rate)))
	}

	var isFirstObserver = true

	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		switchRotateWithPlayerState(HTMusicPlayer.share.rate > 0, isFirstObserver ? false : true)
		isFirstObserver = false
	}

}

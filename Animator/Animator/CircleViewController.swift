//
//  CircleViewController.swift
//  Animator
//
//  Created by hublot on 2018/12/18.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import CoreMotion

class CircleViewController: UIViewController {

	let flowLayout = HTAnimatorCollectionFlowLayout.init()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource () {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func initInterface() {
		view.backgroundColor = UIColor.white
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			NSLayoutConstraint.init(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
		])
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	

}

extension CircleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 15
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
		let red = CGFloat(arc4random() % 255) / 255.0
		let green = CGFloat(arc4random() % 255) / 255.0
		let blue = CGFloat(arc4random() % 255) / 255.0
		cell.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
		cell.layer.cornerRadius = cell.bounds.size.height / 2.0
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let size = CGSize.init(width: 60, height: 60)
		return size
	}
	
}







class HTAnimatorCollectionFlowLayout: UICollectionViewFlowLayout {
	
	override class var layoutAttributesClass: AnyClass {
		return HTAnimatorLayoutAttributes.self
	}
	
	lazy var animator: UIDynamicAnimator = {
		let animator = UIDynamicAnimator.init(collectionViewLayout: self)
		return animator
	}()
	
	lazy var collision: UICollisionBehavior = {
		let collision = UICollisionBehavior.init(items: [])
		collision.translatesReferenceBoundsIntoBoundary = true
		return collision
	}()
	
	lazy var gravity: UIGravityBehavior = {
		let gravity = UIGravityBehavior.init(items: [])
		return gravity
	}()
	
	lazy var motionManager: CMMotionManager = {
		let motionManager = CMMotionManager.init()
		motionManager.accelerometerUpdateInterval = 0.1
		let queue = OperationQueue.init()
		motionManager.startAccelerometerUpdates(to: queue, withHandler: { [weak self] (acclerometerData, error) in
			OperationQueue.main.addOperation {
				self?.gravity.gravityDirection = CGVector.init(dx: acclerometerData?.acceleration.x ?? 0, dy: -(acclerometerData?.acceleration.y ?? 0))
			}
		})
		return motionManager
	}()
	
	override var collectionViewContentSize: CGSize {
		return collectionView?.bounds.size ?? CGSize.zero
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let attributedList = animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
		return attributedList
	}
	
	override func prepare() {
		super.prepare()
		guard animator.behaviors.count <= 0 else {
			return
		}
		let contentSize = collectionViewContentSize
		let attributedList = super.layoutAttributesForElements(in: CGRect.init(origin: CGPoint.zero, size: contentSize)) ?? [UICollectionViewLayoutAttributes]()
		for attributed in attributedList {
			gravity.addItem(attributed)
			collision.addItem(attributed)
		}
		if attributedList.count > 0 {
			animator.addBehavior(gravity)
			animator.addBehavior(collision)
			_ = motionManager
		}
	}
	
}

class HTAnimatorLayoutAttributes: UICollectionViewLayoutAttributes {
	
	@available(iOS 9.0, *)
	override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
		return .ellipse
	}
	
}



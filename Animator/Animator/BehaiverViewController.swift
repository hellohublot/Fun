//
//  BehaiverViewController.swift
//  Animator
//
//  Created by hublot on 2018/12/18.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class BehaviorViewController: UIViewController {

	let flowLayout = HTBehaviorCollectionFlowLayout.init()
	
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

extension BehaviorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 500
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


class HTBehaviorCollectionFlowLayout: UICollectionViewFlowLayout {
	
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		let delta = newBounds.origin.y - (collectionView?.bounds.origin.y ?? 0)
		let location = collectionView?.panGestureRecognizer.location(in: collectionView) ?? CGPoint.zero		
		for behavior in (animator.behaviors as? [UIAttachmentBehavior] ?? [UIAttachmentBehavior]()) {
			guard let attributed = behavior.items.first as? UICollectionViewLayoutAttributes, newBounds.intersects(attributed.frame) else {
				continue
			}
			let xDistanceFromTouch = abs(location.x - behavior.anchorPoint.x)
			let yDistanceFromTouch = abs(location.y - behavior.anchorPoint.y)
			let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0
			var newCenter = attributed.center
			if (delta < 0) {
				newCenter.y += max(delta, delta * scrollResistance)
			} else {
				newCenter.y += min(delta, delta * scrollResistance)
			}
			attributed.center = newCenter
			animator.updateItem(usingCurrentState: attributed)
		}
		return false
	}
	
	lazy var animator: UIDynamicAnimator = {
		let animator = UIDynamicAnimator.init(collectionViewLayout: self)
		return animator
	}()
	
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
			let behavior = UIAttachmentBehavior.init(item: attributed, attachedToAnchor: attributed.center)
			behavior.length = 0
			behavior.damping = 0.8
			behavior.frequency = 1
			animator.addBehavior(behavior)
		}
	}
	
}

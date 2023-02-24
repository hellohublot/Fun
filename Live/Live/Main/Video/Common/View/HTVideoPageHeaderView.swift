//
//  HTVideoPageHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoPageHeaderView: UIView {

	weak var pageDelegate: UICollectionViewDelegateFlowLayout?
	
	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.bounces = false
		collectionView.scrollsToTop = false
		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		}
		return collectionView
	}()
	
	lazy var pageLineLayer: CAGradientLayer = {
		let layer = CAGradientLayer.init()
		layer.startPoint = CGPoint.init(x: 0, y: 0)
		layer.endPoint = CGPoint.init(x: 1, y: 0)
		layer.colors = [
			UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor,
		]
		layer.locations = [0, 1]
		layer.masksToBounds = true
		return layer
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(collectionView)
		collectionView.layer.addSublayer(pageLineLayer)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension HTVideoPageHeaderView: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		pageDelegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTVideoPageHeaderCell.self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return reuseView(collectionView, cellForRowAt: indexPath) as! UICollectionViewCell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let contentInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: 0)
		let width = (collectionView.bounds.size.width - contentInset.left - contentInset.right) / CGFloat(collectionView.cellModelArray().count)
		return CGSize.init(width: width, height: collectionView.bounds.size.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 80, bottom: 0, right: 80)
	}
	
} 


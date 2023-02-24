//
//  HTDiscoverNewsContentNormalCell.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverNewsContentNormalCell: UITableViewCell, ReuseCell {
	
	static let itemSpace: CGFloat = 3
	
	static func modelSize(_ model: NSObject?, _ superSize: CGSize) -> CGSize {
		guard let model = model as? HTDiscoverNewsContentModel else {
			return CGSize.zero
		}
		let width = superSize.width - 20
		var height: CGFloat = 0
		height += model.newsContentAttributedString?.size(CGSize.init(width: width, height: 0)).height ?? 0
		if model.photo.count > 0 {
			height += 15
			let imageLineCount = Int(ceil(CGFloat(model.photo.count) / 3))
			let imageItemWidth = Int((width - itemSpace * 2) / 3) 
			height += CGFloat(imageItemWidth * imageLineCount + (imageLineCount - 1) * Int(itemSpace))
		}
		height += 10
		return CGSize.init(width: superSize.width, height: height)
	}
		
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		return label
	}()
	
	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.isScrollEnabled = false
		return collectionView
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.clear))
		addSubview(titleLabel)
		addSubview(collectionView)
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(0)
			maker.left.equalTo(10)
			maker.right.equalTo(-10)
		}
		collectionView.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(15)
			maker.left.equalTo(10)
			maker.right.equalTo(-10)
			maker.height.equalTo(snp.width).multipliedBy(2)
		}
	}

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		if view == collectionView {
			return self
		}
		return view
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTDiscoverNewsContentModel else {
			return
		}
		titleLabel.attributedText = model.newsContentAttributedString
		collectionView.setCellModelArray(model.photo, proxy: self)
		collectionView.reloadData()
	}

}

extension HTDiscoverNewsContentNormalCell: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTDiscoverNewsContentPhotoCell.self
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
	
	func itemWidthFromItemSingleColumnCount(_ count: Int, _ section: Int) -> CGFloat {
		var width = collectionView.frame.size.width
		let sectionInset = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumInteritemWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
		width -= (sectionInset.left + sectionInset.right)
		width -= (CGFloat(count - 1) * minimumInteritemWidth)
		return floor(width / CGFloat(count))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = itemWidthFromItemSingleColumnCount(3, indexPath.section)
		return CGSize.init(width: width, height: width)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return type(of: self).itemSpace
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return type(of: self).itemSpace
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}

	
}

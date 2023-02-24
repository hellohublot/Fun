//
//  HTVideoRecordTabBar.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTVideoRecordTabBar: UIView {

	lazy var whiteCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = UIColor.init(white: 0, alpha: 0.35)
		return collectionView
	}()
	
	lazy var sliderView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.init(red: 1, green: 0.87, blue: 0.02, alpha: 1)
		view.layer.masksToBounds = true
		return view
	}()
	
	lazy var sliderMask: UIView = {
		let view = UIView.init()
		view.layer.masksToBounds = true
		view.backgroundColor = UIColor.white
		return view
	}()
	
	lazy var blackCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isScrollEnabled = false
		collectionView.isUserInteractionEnabled = false
		return collectionView
	}()
	
	lazy var videoButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "ac5ab203f4cfe0fe6f94b54dfd81d58e"), for: .normal)
		button.setImage(UIImage.init(named: "8ae537223e9527306c7a6a903dd1cc94"), for: .selected)
		button.whenTouch(inside: { [weak self] (_, _) in
			self?.videoButton.isSelected = !(self?.videoButton.isSelected ?? true)
		})
		return button
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		whiteCollectionView.layer.cornerRadius = whiteCollectionView.bounds.size.height / 2.0
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(videoButton)
		addSubview(whiteCollectionView)
		addSubview(blackCollectionView)
		whiteCollectionView.addSubview(sliderView)
		blackCollectionView.layer.mask = sliderMask.layer
		videoButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-10)
			maker.centerX.equalTo(self)
		}
		whiteCollectionView.snp.makeConstraints { (maker) in
			maker.left.equalTo(20)
			maker.right.equalTo(-20)
			maker.bottom.equalTo(videoButton.snp.top).offset(-10)
			maker.height.equalTo(27)
		}
		blackCollectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(whiteCollectionView)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension HTVideoRecordTabBar: CollectionViewThrough, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: false)
		collectionView.sendSubview(toBack: sliderView)
		guard let frame = collectionView.layoutAttributesForItem(at: indexPath)?.frame else {
			return
		}
		let width: CGFloat = 40
		let height: CGFloat = 23
		sliderView.layer.cornerRadius = height / 2.0
		sliderMask.layer.cornerRadius = sliderView.layer.cornerRadius 
		UIView.animate(withDuration: 0.25, animations: {
			self.sliderView.frame = CGRect.init(x: frame.minX + (frame.width - width) / 2.0, y: (frame.size.height - height) / 2.0, width: width, height: height)
			self.sliderMask.frame = self.sliderView.frame
		}, completion: nil)
	}
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTVideoRecordSpeedCell.self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = reuseView(collectionView, cellForRowAt: indexPath) as? HTVideoRecordSpeedCell
		cell?.titleButton.isSelected = collectionView == blackCollectionView
		return cell!
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = ceil(collectionView.bounds.size.width / CGFloat(collectionView.cellModelArray().count))
		return CGSize.init(width: width, height: collectionView.bounds.size.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
}

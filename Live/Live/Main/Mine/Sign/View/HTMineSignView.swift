//
//  HTMineSignView.swift
//  Live
//
//  Created by hublot on 2019/2/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineSignView: UIView, ReuseCell {

	lazy var headerImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleToFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "5506710f916112862e5e9abbd0a73867")
		return imageView
	}()

	lazy var signDateLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.white
		label.textAlignment = .center
		label.text = "2019.02.11-2019.02.17"
		return label
	}()

	lazy var questionImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "269fbd214082204eb7abd5c68a0ac29c")
		return imageView
	}()

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.isScrollEnabled = false
		return collectionView
	}()

	lazy var dismissButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.setImage(UIImage.init(named: "ba634837db864b132f8e079cbba42757"), for: .normal)
		return button
	}()

	lazy var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer.init()
		gradientLayer.locations = [0, 1]
		gradientLayer.startPoint = CGPoint.zero
		gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
		gradientLayer.colors = [
			UIColor.init(red: 1, green: 0.721569, blue: 0.615686, alpha: 1).cgColor,
			UIColor.init(red: 1, green: 0.317647, blue: 0.607843, alpha: 1).cgColor,
		]
		return gradientLayer
	}()

	lazy var signButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("签到", for: .normal)
		button.layer.masksToBounds = true
		button.layer.insertSublayer(gradientLayer, at: 0)
		return button
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = signButton.bounds
		signButton.layer.cornerRadius = signButton.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		layer.cornerRadius = 12
		layer.masksToBounds = true

		addSubview(headerImageView)
		addSubview(signDateLabel)
		addSubview(questionImageView)
		addSubview(dismissButton)
		addSubview(collectionView)
		addSubview(signButton)
		headerImageView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
		}
		signDateLabel.snp.makeConstraints { (maker) in
			maker.centerX.equalTo(headerImageView).offset(-18)
			maker.bottom.equalTo(headerImageView).offset(-39)
		}
		questionImageView.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(signDateLabel)
			maker.left.equalTo(signDateLabel.snp.right).offset(30)
		}
		dismissButton.snp.makeConstraints { (maker) in
			maker.top.right.equalTo(headerImageView)
		}
		collectionView.snp.makeConstraints { (maker) in
			maker.left.equalTo(signButton)
			maker.right.equalTo(signButton)
			maker.top.equalTo(headerImageView.snp.bottom).offset(10)
			maker.bottom.equalTo(signButton.snp.top).offset(-20)
		}
		signButton.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-15)
			maker.height.equalTo(35)
			maker.left.equalTo(30)
			maker.right.equalTo(-30)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? [HTMineSignModel] else {
			return
		}
		collectionView.setCellModelArray(model, proxy: self)
		collectionView.reloadData()
	}

}

extension HTMineSignView: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineSignCell.self
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

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}

	func itemWidthFromItemSingleColumnCount(_ count: Int, _ section: Int) -> CGFloat {
		var width = collectionView.frame.size.width
		let sectionInset = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumInteritemWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
		width -= (sectionInset.left + sectionInset.right)
		width -= (CGFloat(count - 1) * minimumInteritemWidth)
		return floor(width / CGFloat(count))
	}

	func itemHeightFromItemSingleRowCount(_ count: Int, _ section: Int) -> CGFloat {
		var height = collectionView.frame.size.height
		let sectionInset = collectionView(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: section)
		let minimumLineSpacingHeight = collectionView(collectionView, layout: collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: section)
		height -= (sectionInset.top + sectionInset.bottom)
		height -= (CGFloat(count - 1) * minimumLineSpacingHeight)
		return floor(height / CGFloat(count))
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let model = collectionView.cellModelArray()[indexPath.row] as? HTMineSignModel
		let height = itemHeightFromItemSingleRowCount(2, indexPath.section)
		var width = itemWidthFromItemSingleColumnCount(4, indexPath.section)
		switch model?.type {
		case .box?:
			width = itemWidthFromItemSingleColumnCount(2, indexPath.section)
		default:
			break
		}
		return CGSize.init(width: width, height: height)
	}

}

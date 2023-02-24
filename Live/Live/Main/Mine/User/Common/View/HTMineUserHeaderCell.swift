//
//  HTMineUserHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineUserHeaderCell: UITableViewCell, ReuseCell {

	lazy var headImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.layer.borderWidth = 1
		imageView.layer.borderColor = UIColor.white.cgColor
		return imageView
	}()
	
	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var countLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = UIColor.white
		return label
	}()
	
	lazy var liveStateButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setTitle("未直播", for: .normal)
		button.setTitle("直播中", for: .selected)
		button.setBackgroundImage(UIImage.init(named: "f2baa5ba4ecb9c7b5ab007567df2019c"), for: .normal)
		button.setBackgroundImage(UIImage.init(named: "1f66106e26fe7163736ab996124cde14"), for: .selected)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 10, left: 35, bottom: 15, right: 15)
		return button
	}()
	
	lazy var badgeTitleButton: UIButton = {
		let button = UIButton.init(frame: CGRect.zero)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		button.setTitleColor(UIColor.black, for: .normal)
		button.setTitle("勋章", for: .normal)
		button.setImage(UIImage.init(named: "e194c7294e301ccc964805e0fbb29dc2")?.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)), for: .normal)
		button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 8)
		return button
	}()
	
	lazy var badgeContentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.layer.insertSublayer(badgeContentLayer, at: 0)
		return view
	}()
	
	lazy var badgeContentLayer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.fillColor = UIColor.white.cgColor
		return layer
	}()

	lazy var badgeCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		badgeContentLayer.path = UIBezierPath.init(roundedRect: badgeContentView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: 10, height: 10)).cgPath
		headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = UIColor.clear
		addSubview(badgeContentView)
		addSubview(badgeTitleButton)
		addSubview(headImageView)
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(countLabel)
		addSubview(liveStateButton)
		addSubview(badgeCollectionView)
		badgeContentView.snp.makeConstraints { (maker) in
			maker.height.equalTo(60)
			maker.bottom.left.right.equalTo(0)
		}
		badgeTitleButton.snp.makeConstraints { (maker) in
			maker.left.equalTo(15)
			maker.centerY.equalTo(badgeContentView)
		}
		badgeCollectionView.snp.makeConstraints { (maker) in
			maker.top.equalTo(badgeContentView).offset(14)
			maker.bottom.equalTo(badgeContentView).offset(-14)
			maker.left.equalTo(badgeTitleButton.snp.right).offset(15)
			maker.right.equalTo(-20)
		}
		headImageView.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(countLabel.snp.top).offset(-25)
			maker.left.equalTo(20)
			maker.width.height.equalTo(70)
		}
		titleLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(headImageView).offset(10)
			maker.left.equalTo(headImageView.snp.right).offset(15)
			maker.right.equalTo(-15)
		}
		detailLabel.snp.makeConstraints { (maker) in
			maker.top.equalTo(titleLabel.snp.bottom).offset(15)
			maker.left.equalTo(titleLabel)
			maker.right.equalTo(-15)
		}
		countLabel.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(badgeContentView.snp.top).offset(-30)
			maker.left.equalTo(headImageView)
		}
		liveStateButton.snp.makeConstraints { (maker) in
			maker.centerY.equalTo(countLabel)
			maker.right.equalTo(-20)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineUserInfoModel else {
			return
		}
		headImageView.kf.setImage(with: Request.url(model.phonehallposter), placeholder: Request.placeImage)
		titleLabel.attributedText = {
			let font = UIFont.systemFont(ofSize: 18)
			let attributedString = NSMutableAttributedString.init()
			attributedString.append(NSAttributedString.init(string: model.nickname, attributes: [
				.font: font,
				.foregroundColor: UIColor.white
				]))
			var image = UIImage.init(named: "level_\(model.creditLevel)_33x14_") ?? UIImage()
			image = image.imageInsert(UIColor.clear, UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0))
			let attachment = NSTextAttachment.init()
			attachment.image = image
			attachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - image.size.height) / 2.0, width: image.size.width, height: image.size.height)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			return attributedString
		}()
		detailLabel.text = "ID: \(model.uid)"
		liveStateButton.isSelected = (model.isplay == "1")
		countLabel.text = "\(model.fanscount)粉丝      \(model.guardcount)关注"
		badgeCollectionView.setCellModelArray(model.badgeList, proxy: self)
	}

}

extension HTMineUserHeaderCell: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineUserHeaderBadgeCell.self
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
		return CGSize.init(width: collectionView.bounds.size.height, height: collectionView.bounds.size.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}

}

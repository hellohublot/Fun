//
//  HTMineStoreNumberSectionHeaderView.swift
//  Live
//
//  Created by hublot on 2019/1/12.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTMineStoreNumberSectionHeaderView: UICollectionReusableView, ReuseCell {

	var cellDidSelected: ((_: Int) -> Void)?

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}()

	lazy var searchTextField: UITextField = {
		let textField = UITextField.init(frame: CGRect.zero)
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.spellCheckingType = .no
		textField.keyboardAppearance = .dark
		textField.clearButtonMode = .whileEditing
		let leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 30))
		leftImageView.contentMode = .center
		leftImageView.layer.masksToBounds = true
		leftImageView.image = UIImage.init(named: "f5756e0863d4b0a5403b5e01b824fa7d")
		textField.leftView = leftImageView
		textField.leftViewMode = .always
		textField.font = UIFont.systemFont(ofSize: 14)
		textField.textColor = UIColor.black
		textField.layer.borderWidth = 1 / UIScreen.main.scale
		textField.layer.borderColor = UIColor.init(white: 0, alpha: 0.2).cgColor
		textField.layer.masksToBounds = true
		textField.placeholder = "搜索你想要的靓号"
		return textField
	}()

	override func layoutSubviews() {
		super.layoutSubviews()
		searchTextField.layer.cornerRadius = searchTextField.bounds.size.height / 2.0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(collectionView)
		addSubview(searchTextField)
		collectionView.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.bottom.equalTo(searchTextField.snp.top).offset(-10)
		}
		searchTextField.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(-8)
			maker.left.equalTo(8)
			maker.right.equalTo(-8)
			maker.height.equalTo(30)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? HTMineStoreNumberSectionModel else {
			return
		}
		collectionView.setCellModelArray(model.pageModelArray, proxy: self)
		collectionView.reloadData()
	}

        
}

extension HTMineStoreNumberSectionHeaderView: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTMineStoreNumberHeaderCell.self
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
		return CGSize.init(width: 90, height: collectionView.bounds.size.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		cellDidSelected?(indexPath.row)
	}

}


//
//  HTLeftAlignFlowLayout.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLeftAlignFlowLayout: UICollectionViewFlowLayout {
	
	func minimumLineSpacingForSection(_ section: Int) -> CGFloat {
		if let collectionView = collectionView, let minimumLineSpacing = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: section) {
			return minimumLineSpacing
		}
		return minimumLineSpacing
	}
	
	func minimumInteritemSpacingForSection(_ section: Int) -> CGFloat {
		if let collectionView = collectionView, let minimumInteritemSpacing = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) {
			return minimumInteritemSpacing
		}
		return minimumInteritemSpacing
	}
	
	func sectionInsetForSection(_ section: Int) -> UIEdgeInsets {
		if let collectionView = collectionView, let sectionInset = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, insetForSectionAt: section) {
			return sectionInset
		}
		return sectionInset
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let attributedList = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]() 
		for (index, attributed) in attributedList.enumerated() {
			if attributed.indexPath.row != 0, index != 0 {
				let previous = attributedList[index - 1]
				if previous.indexPath.section == attributed.indexPath.section, previous.frame.maxX < attributed.frame.minX {
					attributed.frame.origin.x = min(previous.frame.maxX + minimumInteritemSpacingForSection(attributed.indexPath.section), attributed.frame.origin.x)
				}
			}
		}
		return attributedList
	}

}

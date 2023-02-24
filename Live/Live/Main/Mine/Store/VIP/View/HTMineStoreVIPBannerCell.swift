//
//  HTMineStoreVIPBannerCell.swift
//  Live
//
//  Created by hublot on 2019/1/10.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTScrollPageView

class HTMineStoreVIPBannerCell: UICollectionViewCell, ReuseCell {
	
	var modelArray = [HTMineStoreVIPBannerModel]()
	
	lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "dc50ccd00d90a21a833c784d2469538f")
		return imageView
	}()
	
	lazy var flagImageView: UIImageView = {
		let imageView = UIImageView.init(frame: CGRect.zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.masksToBounds = true
		imageView.image = UIImage.init(named: "e1d3ceaa72b78d9e8215c28390d46fb5")
		return imageView
	}()
	
	lazy var pageControl: UIPageControl = {
		let pageControl = UIPageControl.init(frame: CGRect.zero)
		pageControl.isUserInteractionEnabled = false
		pageControl.pageIndicatorTintColor = UIColor.white
		pageControl.currentPageIndicatorTintColor = UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)
		return pageControl
	}()
	
	lazy var bannerView: HTScrollPageView = {
		let bannerView = HTScrollPageView.init(frame: CGRect.zero)
		bannerView.delegate = self
		bannerView.autoScrollTimeInterval = 0
		return bannerView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(backgroundImageView)
		addSubview(flagImageView)
		addSubview(pageControl)
		addSubview(bannerView)
		addSubview(pageControl)
		backgroundImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		flagImageView.snp.makeConstraints { (maker) in
			maker.centerX.bottom.equalTo(self)
		}
		pageControl.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.bottom.equalTo(flagImageView.snp.top).offset(-5)
			maker.height.equalTo(15)
		}
		bannerView.snp.makeConstraints { (maker) in
			maker.top.equalTo(15)
			maker.bottom.equalTo(pageControl.snp.top).offset(-5)
			maker.left.right.equalTo(0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? [HTMineStoreVIPBannerModel], model != modelArray else {
			return
		}
		modelArray = model
		pageControl.numberOfPages = modelArray.count
		bannerView.reloadData()
	}
    
}

extension HTMineStoreVIPBannerCell: HTScrollPageDelegate {
	
	func number(of pageView: HTScrollPageView!) -> Int {
		return modelArray.count
	}
	
	func buttonWillDisplay(_ pageView: HTScrollPageView!, button: UIButton!, indexRow: Int) {
		let model = modelArray[indexRow]
		button.setImage(UIImage.init(named: model.image ?? ""), for: .normal)
	}
	
	func buttonDidDisplay(_ pageView: HTScrollPageView!, button: UIButton!, indexRow: Int) {
		pageControl.currentPage = indexRow
	}
	
}

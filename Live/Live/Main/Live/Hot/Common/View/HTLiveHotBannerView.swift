//
//  HTLiveHotBannerView.swift
//  Live
//
//  Created by hublot on 2018/12/30.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTScrollPageView

class HTLiveHotBannerView: UICollectionViewCell, ReuseCell {

	var modelArray = [HTLiveHotBannerModel]()

	lazy var bannerView: HTScrollPageView = {
		let bannerView = HTScrollPageView.init(frame: CGRect.zero)
		bannerView.delegate = self
		return bannerView
	}()

	lazy var pageControl: UIPageControl = {
		let pageControl = UIPageControl.init(frame: CGRect.zero)
		pageControl.isUserInteractionEnabled = false
		pageControl.hidesForSinglePage = true
		return pageControl
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(bannerView)
		addSubview(pageControl)
		bannerView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8))
		}
		pageControl.snp.makeConstraints { (maker) in
			maker.bottom.equalTo(0)
			maker.height.equalTo(20)
			maker.right.equalTo(bannerView).offset(-16)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setModel(_ model: Any?, for indexPath: IndexPath) {
		guard let model = model as? [HTLiveHotBannerModel], model != modelArray else {
			return
		}
		modelArray = model
		pageControl.numberOfPages = modelArray.count
		bannerView.reloadData()
	}
    
}

extension HTLiveHotBannerView: HTScrollPageDelegate {

	func number(of pageView: HTScrollPageView!) -> Int {
		return modelArray.count
	}

	func buttonInitPageView(_ pageView: HTScrollPageView!, button: UIButton!) {
		button.imageView?.contentMode = .scaleAspectFill
		button.imageView?.layer.masksToBounds = true
		button.imageView?.layer.cornerRadius = 5
	}

	func buttonWillDisplay(_ pageView: HTScrollPageView!, button: UIButton!, indexRow: Int) {
		let model = modelArray[indexRow]
		button.kf.setImage(with: Request.url(model.focus_pic_url), for: .normal, placeholder: Request.placeImage)
	}

	func buttonDidDisplay(_ pageView: HTScrollPageView!, button: UIButton!, indexRow: Int) {
		pageControl.currentPage = indexRow
	}
    
    func buttonSelectedPageView(_ pageView: HTScrollPageView!, button: UIButton!, indexPath indexRow: Int) {
        let model = modelArray[indexRow]
        let webController = HTWebController()
        webController.initalizeUrl = Request.url(model.focus_link_url)
        Appdelegate.navigationController()?.pushViewController(webController, animated: true)
    }

}


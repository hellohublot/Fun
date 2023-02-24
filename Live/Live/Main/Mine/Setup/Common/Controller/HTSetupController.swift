//
//  HTSetupController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTCollectionFallLayout

class HTSetupController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let fallLayout = HTCollectionFallLayout.init()
		fallLayout.delegate = self
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: fallLayout)
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = UIColor.clear
		fallLayout.register(HTSetupSectionBackgroundView.self, forDecorationViewOfKind: HTSetupSectionBackgroundView.identifier)
		return collectionView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		let modelArray = HTSetupSectionModel.packModelArray(false)
		collectionView.setSectionModelArray(modelArray, proxy: self)
		collectionView.reloadData()

		reloadSetupCollectoinModelArray(false)
	}

	func reloadSetupCollectoinModelArray(_ clearCache: Bool) {
		DispatchQueue.global().async {
			if clearCache {
				HTHud.show(withStatus: "清理中...")
				HTFileManager.deleterFloder(HTSetupModel.cacheFloder)
			}
			let modelArray = HTSetupSectionModel.packModelArray(true)
			DispatchQueue.main.async {
				HTHud.dismiss()
				self.collectionView.setSectionModelArray(modelArray, proxy: self)
				self.collectionView.reloadData()
			}
		}
	}
	
	func initInterface() {
		navigationItem.title = "设置"
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTSetupController: CollectionViewThrough, HTCollectionFallDelegateLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTSetupSectionModel
		switch sectionModel?.type {
		case .exit?:
			return HTSetupExitCell.self
		default:
			return HTSetupActionCell.self
		}
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountForSectionAt section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTSetupSectionModel
		switch sectionModel?.type {
		case .exit?:
			return UIEdgeInsets.init(top: 30, left: 0, bottom: 0, right: 0)
		default:
			return UIEdgeInsets.init(top: 15, left: 0, bottom: 0, right: 0)			
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, layoutAttributesForDecorationViewInSection section: Int, sectionContentMinY minY: CGFloat, sectionContentMaxY maxY: CGFloat) -> UICollectionViewLayoutAttributes? {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTSetupSectionModel
		if case .exit? = sectionModel?.type {
			return nil
		}
		let attributed = HTCollectionViewLayoutAttributes.init(forDecorationViewOfKind: HTSetupSectionBackgroundView.identifier, with: IndexPath.init(row: 0, section: section))
		let headerHeight = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section).top
		attributed.frame = CGRect.init(x: 0, y: minY + headerHeight, width: collectionView.bounds.size.width, height: maxY - minY - headerHeight)
		attributed.zIndex = -1
		attributed.model = sectionModel as Any
		return attributed
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let model = collectionView.sectionModelArray()[indexPath.section].modelArray[indexPath.row] as? HTSetupModel
		var willController: UIViewController?
		switch model?.type {
		case .password?:
			willController = HTModifyPasswordController()
		case .phonebind?:
            let phoneController = HTSetupPhoneController()
            phoneController.type = .bind
			willController = phoneController
        case .phonecancel(let phoneString)?:
            let phoneController = HTSetupPhoneController()
            phoneController.type = .cancel(phoneString)
            willController = phoneController
		case .black?:
			willController = HTSetupBlackController()
		case .friend?:
			willController = HTSetupFriendController()
		case .notify?:
			willController = HTSetupNotifyController()
		case .animation?:
			willController = HTSetupAnimationController()
		case .cache?:
			reloadSetupCollectoinModelArray(true)
		case .issue?:
			let webController = HTWebController()
			webController.initalizeUrl = Request.url("https://bcfeedback.taobao.com/")
			willController = webController
		case .policy?:
			let webController = HTWebController()
			webController.initalizeUrl = Request.url("https://www.9xiu.com/activity/agreement")
			willController = webController
		case .about?:
			willController = HTSetupAboutController()
		default:
			break			
		}
		if let willController = willController {
			navigationController?.pushViewController(willController, animated: true)
		}
	}
	
}

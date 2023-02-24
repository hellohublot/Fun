//
//  HTSetupFriendController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftRefresh
import HTSwiftPlaceholder
import HTCollectionFallLayout

class HTSetupFriendController: UIViewController {

	lazy var collectionView: UICollectionView = {
		let fallLayout = HTCollectionFallLayout.init()
		fallLayout.delegate = self
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: fallLayout)
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = UIColor.clear
		fallLayout.register(HTSetupFriendBackgroundView.self, forDecorationViewOfKind: HTSetupFriendBackgroundView.identifier)
		return collectionView
	}()

	
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
        let placeholder = Placeholder.default
        collectionView.placeholderProvider = placeholder
        placeholder.reloadNetworkHandler = { [weak self] in
            self?.collectionView.placeholderState = .firstRefresh
            Request.list.userConfigList({ (result) in
                guard let value = result.value as? [String: Any] else {
                    self?.collectionView.placeholderState = .errorNetwork
                    return
                }
                self?.collectionView.placeholderState = .none
                let modelArray = HTSetupFriendModel.packModelArray(value)
                self?.collectionView.setCellModelArray(modelArray, proxy: self)
                self?.collectionView.reloadData()
            })
        }
        placeholder.reloadNetwork()
	}
	
	func initInterface() {
		navigationItem.title = "好友设置"
		view.backgroundColor = UIColor.init(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

extension HTSetupFriendController: CollectionViewThrough, HTCollectionFallDelegateLayout {
	
	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		return HTSetupFriendCell.self
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
		return 60
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, layoutAttributesForDecorationViewInSection section: Int, sectionContentMinY minY: CGFloat, sectionContentMaxY maxY: CGFloat) -> UICollectionViewLayoutAttributes? {
		let attributed = HTCollectionViewLayoutAttributes.init(forDecorationViewOfKind: HTSetupFriendBackgroundView.identifier, with: IndexPath.init(row: 0, section: section))
		let headerHeight = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section).top
		attributed.frame = CGRect.init(x: 0, y: minY + headerHeight, width: collectionView.bounds.size.width, height: maxY - minY - headerHeight)
		attributed.zIndex = -1
		return attributed
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
        let model = collectionView.cellModelArray()[indexPath.row] as? HTSetupFriendModel
        Request.action.modifyUserFriend(model?.text ?? "") { [weak self] (result) in
            guard let _ = result.value else {
                return
            }
            let placeholder = self?.collectionView.placeholderProvider as? Placeholder
            placeholder?.reloadNetwork()
        }
	}

	
}

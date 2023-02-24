//
//  HTDiscoverHomeDetailController.swift
//  Live
//
//  Created by hublot on 2019/1/16.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftPlaceholder

class HTDiscoverHomeDetailController: UIViewController {

	var homeIdString = ""

	lazy var backgroundView: HTDiscoverHomeDetailBackgroundView = {
		let backgroundView = HTDiscoverHomeDetailBackgroundView.init(frame: CGRect.zero)
		return backgroundView
	}()

	lazy var collectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.clear
		collectionView.alwaysBounceVertical = true
		collectionView.register(HTDiscoverHomeDetailSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HTDiscoverHomeDetailSectionHeaderView.identifier)
		return collectionView
	}()

	/*-------------------------------------/ init /-----------------------------------*/

	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}

	func initDataSource() {
		let placeHolder = Placeholder.default
		collectionView.placeholderProvider = placeHolder
		placeHolder.reloadNetworkHandler = { [weak self] in
			self?.collectionView.placeholderState = .firstRefresh
			Request.list.homeDetail(self?.homeIdString ?? "") { (result) in
				guard let value = result.value as? [String: Any], let detailModel = HTDiscoverHomeDetailModel.mj_object(withKeyValues: value) else {
					self?.collectionView.placeholderState = .errorNetwork
					return
				}
				self?.backgroundView.setModel(detailModel)
				let sectionModelArray = HTDiscoverHomeDetailSectionModel.packModelArray(detailModel)
				self?.collectionView.placeholderState = .none
				self?.collectionView.setSectionModelArray(sectionModelArray, proxy: self)
				self?.collectionView.reloadData()
			}
		}
		placeHolder.reloadNetwork()
	}

	func initInterface() {
		navigationItem.title = "家族详情"
		view.addSubview(collectionView)
		collectionView.backgroundView = backgroundView

		if #available(iOS 11.0, *) {
			collectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		collectionView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}

		view.layoutIfNeeded()
		scrollViewDidScroll(collectionView)
	}

	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension HTDiscoverHomeDetailController: CollectionViewThrough, UICollectionViewDelegateFlowLayout {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffsetY = scrollView.contentOffset.y
		backgroundView.reloadTableViewContentOffset(-contentOffsetY)
	}

	func cellClass<T>(_ reuseView: T, for indexPath: IndexPath) -> ReuseCell.Type where T : ReuseAbleView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeDetailSectionModel
		switch sectionModel?.type {
		case .info?:
			return HTDiscoverHomeDetailInfoCell.self
		case .circle?:
			return HTDiscoverHomeDetailCircleCell.self
		case .radio?:
			return HTDiscoverHomeDetailRadioCell.self
		case .leader?:
			return HTDiscoverHomeDetailLeaderCell.self
		case .member?:
			return HTDiscoverHomeDetailMemberView.self
		case .short?:
			return HTDiscoverHomeDetailShortCell.self
		default:
			return HTDiscoverHomeDetailShortCell.self
		}
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return reuseViewNumberOfSections(in: collectionView)
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reuseView(collectionView, numberOfRowsInSection: section)
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeDetailSectionModel
		let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HTDiscoverHomeDetailSectionHeaderView.identifier, for: indexPath)
		(cell as? ReuseCell)?.setModel(sectionModel, for: indexPath)
		(cell as? HTDiscoverHomeDetailSectionHeaderView)?.detailButton.whenTouch(inside: { [weak self] (_, _) in
			var willController: UIViewController?
			switch sectionModel?.type {
			case .radio?:
				let radioController = HTDiscoverHomeDetailRadioController()
				radioController.homeIdString = self?.homeIdString ?? ""
				willController = radioController
			case .member?:
				let memberController = HTDiscoverHomeDetailMemberController()
				memberController.homeIdString = self?.homeIdString ?? ""
				willController = memberController
			default:
				break
			}
			if let willController = willController {
				self?.navigationController?.pushViewController(willController, animated: true)
			}
		})
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverHomeDetailSectionModel
		switch sectionModel?.type {
		case .radio?, .leader?, .member?, .short?:
			return CGSize.init(width: collectionView.bounds.size.width, height: 60)
		default:
			return CGSize.zero
		}
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
		let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeDetailSectionModel
		switch sectionModel?.type {
		case .info?:
			let model = sectionModel?.modelArray[indexPath.row] as? NSObject
			let superSize = CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 0)
			return HTDiscoverHomeDetailInfoCell.cacheModelSize(model, superSize)
		case .circle?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(3, indexPath.section), height: 75)
		case .radio?:
			let width = itemWidthFromItemSingleColumnCount(4, indexPath.section)
			return CGSize.init(width: width, height: width)
		case .leader?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 94)
		case .member?:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 75)
		case .short?:
			let model = sectionModel?.modelArray[indexPath.row] as? NSObject
			let superSize = CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 0)
			return HTDiscoverHomeDetailShortCell.cacheModelSize(model, superSize)
		default:
			return CGSize.init(width: itemWidthFromItemSingleColumnCount(1, indexPath.section), height: 150)
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverHomeDetailSectionModel
		switch sectionModel?.type {
		case .circle?:
			return 10
		case .radio?:
			return 3
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let sectionModel = collectionView.sectionModelArray()[section] as? HTDiscoverHomeDetailSectionModel
		switch sectionModel?.type {
		case .circle?:
			return UIEdgeInsets.init(top: 15, left: 12, bottom: 0, right: 12)
		case .radio?:
			return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
		default:
			return UIEdgeInsets.zero
		}
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sectionModel = collectionView.sectionModelArray()[indexPath.section] as? HTDiscoverHomeDetailSectionModel
        var willController: UIViewController?
        switch sectionModel?.type {
        case .circle?:
            let model = sectionModel?.modelArray[indexPath.row] as? HTDiscoverHomeDetailCircleModel
            switch model?.type {
            case .rich?:
                let richController = HTDiscoverHomeDetailRichController()
                richController.homeIdString = homeIdString
                willController = richController
            case .glory?:
                let gloryController = HTDiscoverHomeDetailGloryController()
                gloryController.homeIdString = homeIdString
                willController = gloryController
            case .join?:
                Request.action.homeSendJoin(homeIdString) { (result) in
                    guard let _ = result.value else {
                        return
                    }
                    HTHud.showSuccess(withStatus: "申请发送成功 !")
                    collectionView.respondHeaderRefresh()
                }
            case .exit?:
                Request.action.homeSendExit(homeIdString) { (result) in
                    guard let _ = result.value else {
                        return
                    }
                    HTHud.showSuccess(withStatus: "退出家族成功 !")
                    collectionView.respondHeaderRefresh()
                }
            default:
                break
            }
        default:
            break
        }
        if let willController = willController {
            navigationController?.pushViewController(willController, animated: true)
        }
    }

}

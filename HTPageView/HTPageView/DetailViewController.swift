//
//  DetailViewController.swift
//  HTPageView
//
//  Created by hublot on 2018/12/18.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	let modelArray = HTPageModel.packModelArray()
	
	var selectedPage = -1
	
	var separatorType = 0
	
	lazy var blackHeaderCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = UIColor.clear
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
		return collectionView
	}()
	
	lazy var whiteHeaderCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = UIColor.clear
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
		collectionView.isUserInteractionEnabled = false
		return collectionView
	}()
	
	lazy var contentCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout.init()
		flowLayout.scrollDirection = .horizontal 
		let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.backgroundColor = UIColor.clear
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
		collectionView.allowsSelection = false
		return collectionView
	}()
	
	lazy var separatorLine: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.orange
		return view
	}()
	
	lazy var separatorMask: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		view.backgroundColor = UIColor.orange
		return view
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource () {
		
	}
	
	func initInterface() {
		view.backgroundColor = UIColor.white
		if #available(iOS 11.0, *) {
			blackHeaderCollectionView.contentInsetAdjustmentBehavior = .never
			whiteHeaderCollectionView.contentInsetAdjustmentBehavior = .never
			contentCollectionView.contentInsetAdjustmentBehavior = .never
		} else {
			automaticallyAdjustsScrollViewInsets = false
		}
		view.addSubview(blackHeaderCollectionView)
		view.addSubview(whiteHeaderCollectionView)
		view.addSubview(contentCollectionView)
		blackHeaderCollectionView.translatesAutoresizingMaskIntoConstraints = false
		whiteHeaderCollectionView.translatesAutoresizingMaskIntoConstraints = false
		contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
		let height = (navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height
		NSLayoutConstraint.activate([
			NSLayoutConstraint.init(item: blackHeaderCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height),
			NSLayoutConstraint.init(item: blackHeaderCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: blackHeaderCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
			NSLayoutConstraint.init(item: blackHeaderCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
		])
		NSLayoutConstraint.activate([
			NSLayoutConstraint.init(item: whiteHeaderCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height),
			NSLayoutConstraint.init(item: whiteHeaderCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: whiteHeaderCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
			NSLayoutConstraint.init(item: whiteHeaderCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
		])
		NSLayoutConstraint.activate([
			NSLayoutConstraint.init(item: contentCollectionView, attribute: .top, relatedBy: .equal, toItem: blackHeaderCollectionView, attribute: .bottom, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentCollectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
		])
		
		view.layoutIfNeeded()
		blackHeaderCollectionView.addSubview(separatorLine)
		whiteHeaderCollectionView.layer.mask = separatorMask.layer
		
		separatorLine.layer.cornerRadius = 17.5
		separatorLine.layer.masksToBounds = true
		
		separatorMask.layer.cornerRadius = 17.5
		separatorMask.layer.masksToBounds = true
		
		separatorLine.frame.size = CGSize.init(width: 100, height: 35)
		separatorLine.frame.origin = CGPoint.init(x: 0, y: (blackHeaderCollectionView.bounds.size.height - 35) / 2.0)
		scrollViewDidScroll(contentCollectionView)
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func reloadModelArraySelected(_ selectedIndex: Int) {
		for (i, model) in modelArray.enumerated() {
			if model.selected == true, selectedIndex == i {
				return
			}
			model.selected = false
		}
		modelArray[selectedIndex].selected = true
		//		blackHeaderCollectionView.reloadData()
		//		whiteHeaderCollectionView.reloadData()
		blackHeaderCollectionView.scrollToItem(at: IndexPath.init(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
		whiteHeaderCollectionView.scrollToItem(at: IndexPath.init(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard collectionView == blackHeaderCollectionView else {
			return
		}
		collectionView.deselectItem(at: indexPath, animated: true)
		contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		reloadModelArraySelected(indexPath.row)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView == contentCollectionView else {
			return
		}
		let selectedPage = Int(round(scrollView.contentOffset.x / scrollView.bounds.size.width))
		if selectedPage >= 0, selectedPage < modelArray.count, selectedPage != self.selectedPage {
			reloadModelArraySelected(selectedPage)
			self.selectedPage = selectedPage
		}
		
		whiteHeaderCollectionView.bounds = blackHeaderCollectionView.bounds
		blackHeaderCollectionView.sendSubviewToBack(separatorLine)
		let progress = scrollView.contentOffset.x / scrollView.bounds.size.width
		let translationX = scrollView.panGestureRecognizer.translation(in: scrollView).x
		let fromIndex = Int(translationX <= 0 ? floor(progress) : ceil(progress))
		let toIndex = Int(translationX > 0 ? floor(progress) : ceil(progress))
		let fromCell = blackHeaderCollectionView.cellForItem(at: IndexPath.init(row: fromIndex, section: 0))
		let toCell = blackHeaderCollectionView.cellForItem(at: IndexPath.init(row: toIndex, section: 0))
		let fromFrame = fromCell?.frame ?? CGRect.zero
		let toFrame = toCell?.frame ?? fromFrame
		
		if (separatorType == 0) {
			if fromIndex <= toIndex {
				let width = fromFrame.width + (toFrame.width - fromFrame.width) * (progress - CGFloat(fromIndex))
				let centerX = fromFrame.midX + (toFrame.midX - fromFrame.midX) * (progress - CGFloat(fromIndex))
				separatorLine.frame.size.width = width
				separatorLine.center.x = centerX
			} else {
				let width = fromFrame.width + (toFrame.width - fromFrame.width) * (CGFloat(fromIndex) - progress)
				let centerX = toFrame.midX + (fromFrame.midX - toFrame.midX) * (progress - CGFloat(toIndex))
				separatorLine.frame.size.width = width
				separatorLine.center.x = centerX
			}
		} else {
			if fromIndex <= toIndex {
				if progress - CGFloat(fromIndex) <= 0.5 {
					separatorLine.frame.origin.x = fromFrame.minX
					separatorLine.frame.size.width = fromFrame.width + (toFrame.maxX - fromFrame.maxX) * 2 * (progress - CGFloat(fromIndex))
				} else {
					separatorLine.frame.size.width = toFrame.width + (toFrame.minX - fromFrame.minX) * 2 * (CGFloat(toIndex) - progress)
					separatorLine.frame.origin.x = toFrame.maxX - separatorLine.frame.size.width
				}
			} else {
				if CGFloat(fromIndex) - progress <= 0.5 {
					separatorLine.frame.size.width = fromFrame.width + (fromFrame.minX - toFrame.minX) * 2 * (CGFloat(fromIndex) - progress)
					separatorLine.frame.origin.x = fromFrame.maxX - separatorLine.frame.size.width
				} else {
					separatorLine.frame.origin.x = toFrame.minX
					separatorLine.frame.size.width = toFrame.width + (fromFrame.maxX - toFrame.maxX) * 2 * (progress - CGFloat(toIndex))
				}
			}
		}
		
		separatorMask.frame = separatorLine.frame
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return modelArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
		if collectionView == contentCollectionView {
			let red = CGFloat(Double(arc4random() % 255) / 255.0)
			let green = CGFloat(Double(arc4random() % 255) / 255.0)
			let blue = CGFloat(Double(arc4random() % 255) / 255.0)
			cell.contentView.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
		} else {
			let blackButton = cell.contentView.subviews.last as? UIButton ?? {
				let button = UIButton.init(frame: CGRect.zero)
				button.isUserInteractionEnabled = false
				button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
				if collectionView == whiteHeaderCollectionView {
					button.setTitleColor(UIColor.white, for: .normal)
				} else {
					button.setTitleColor(UIColor.black, for: .normal)
				}
				cell.contentView.addSubview(button)
				button.translatesAutoresizingMaskIntoConstraints = false
				NSLayoutConstraint.activate([
					NSLayoutConstraint.init(item: button, attribute: .top, relatedBy: .equal, toItem: cell.contentView, attribute: .top, multiplier: 1, constant: 7),
					NSLayoutConstraint.init(item: button, attribute: .left, relatedBy: .equal, toItem: cell.contentView, attribute: .left, multiplier: 1, constant: 5),
					NSLayoutConstraint.init(item: button, attribute: .bottom, relatedBy: .equal, toItem: cell.contentView, attribute: .bottom, multiplier: 1, constant: -7),
					NSLayoutConstraint.init(item: button, attribute: .right, relatedBy: .equal, toItem: cell.contentView, attribute: .right, multiplier: 1, constant: -5),
					])
				return button
				}()
			cell.contentView.layoutIfNeeded()
			blackButton.setTitle(modelArray[indexPath.row].title, for: .normal)
			blackButton.layer.cornerRadius = blackButton.bounds.size.height / 2.0
			blackButton.layer.masksToBounds = true
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == contentCollectionView {
			return collectionView.bounds.size
		} else {
			let attributedString = NSAttributedString.init(string: modelArray[indexPath.row].title ?? "", attributes: [
				.font: UIFont.systemFont(ofSize: 16)
				])
			let size = CGSize.init(width: attributedString.boundingRect(with: CGSize.init(width: 0, height: collectionView.bounds.size.height), options: .usesLineFragmentOrigin, context: nil).width + 40, height: collectionView.bounds.size.height)
			return size
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
}

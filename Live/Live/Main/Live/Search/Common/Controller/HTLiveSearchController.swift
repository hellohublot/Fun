//
//  HTLiveSearchController.swift
//  Live
//
//  Created by hublot on 2019/1/15.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveSearchController: UIViewController {
	
	enum HTLiveSearchDisplayType {
		case placeholder
		case result
	}

	lazy var navigationBar: HTLiveSearchNavigationBar = {
		let navigationBar = HTLiveSearchNavigationBar.init(frame: CGRect.zero)
		navigationBar.textField.delegate = self
		navigationBar.textField.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
		return navigationBar
	}()
	
	lazy var contentView: UIView = {
		let view = UIView.init(frame: CGRect.zero)
		return view
	}()

	lazy var placeHolderController: HTLiveSearchPlaceholderController = {
		let placeHolderController = HTLiveSearchPlaceholderController()
		placeHolderController.placeholderHistoryResponse = { [weak self] (historyTitle) in
			guard let this = self else {
				return
			}
			this.navigationBar.textField.text = historyTitle
			this.textFieldValueDidChange()
			let _ = this.textFieldShouldReturn(this.navigationBar.textField)
		}
		return placeHolderController
	}()

	let resultController = HTLiveSearchResultController()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		navigationBar.textField.becomeFirstResponder()
	}
	
	func initInterface() {
		navigationController?.navigationBar.isHidden = true
		view.addSubview(navigationBar)
		view.addSubview(contentView)
		contentView.addSubview(placeHolderController.view)
		contentView.addSubview(resultController.view)
		
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.right.top.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		contentView.snp.makeConstraints { (maker) in
			maker.bottom.left.right.equalTo(0)
			maker.top.equalTo(navigationBar.snp.bottom)
		}
		placeHolderController.view.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		resultController.view.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		
		
		textFieldValueDidChange()
	}
	
	func reloadControllerDisplayType(_ type: HTLiveSearchDisplayType?) {
		for subview in contentView.subviews {
			subview.isHidden = true
		}
		switch type {
		case .placeholder?:
			placeHolderController.view.isHidden = false
			placeHolderController.reloadPlaceholderModelArray()
		case .result?:
			resultController.view.isHidden = false
			resultController.reloadResultModelArrayWithText(navigationBar.textField.text ?? "")
		default:
			break
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
}

extension HTLiveSearchController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard textField.hasText else {
			return true
		}
		textField.resignFirstResponder()
		HTLiveSearchPlaceholderHistoryModel.appendHistory(textField.text ?? "")
		reloadControllerDisplayType(.result)
		return true
	}
	
	@objc func textFieldValueDidChange() {
		if navigationBar.textField.hasText == false {
			navigationBar.textField.clearButtonMode = .never
			reloadControllerDisplayType(.placeholder)
		} else {
			navigationBar.textField.clearButtonMode = .always		
		}
	}
	
}

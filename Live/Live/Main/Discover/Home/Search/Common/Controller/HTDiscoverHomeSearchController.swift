//
//  HTDiscoverHomeSearchController.swift
//  Live
//
//  Created by hublot on 2019/1/20.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverHomeSearchController: UIViewController {

	lazy var navigationBar: HTDiscoverHomeSearchNavigationBar = {
		let navigationBar = HTDiscoverHomeSearchNavigationBar.init(frame: CGRect.zero)
		navigationBar.textField.delegate = self
		navigationBar.textField.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
		return navigationBar
	}()

	let resultController = HTDiscoverHomeSearchResultController()

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
		view.addSubview(resultController.view)
		navigationBar.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		resultController.view.snp.makeConstraints { (maker) in
			maker.left.right.bottom.equalTo(0)
			maker.top.equalTo(navigationBar.snp.bottom)
		}
	}

	/*-------------------------------------/ controller override /-----------------------------------*/



}

extension HTDiscoverHomeSearchController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard textField.hasText else {
			return true
		}
		textField.resignFirstResponder()
		resultController.reloadResultModelArrayWithText(textField.text ?? "")
		return true
	}

	@objc func textFieldValueDidChange() {
		if navigationBar.textField.hasText == false {
			navigationBar.textField.clearButtonMode = .never
		} else {
			navigationBar.textField.clearButtonMode = .always
		}
	}

}

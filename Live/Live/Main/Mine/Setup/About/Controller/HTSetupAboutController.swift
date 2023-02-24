//
//  HTSetupAboutController.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTSetupAboutController: UIViewController {

	lazy var infoView: HTSetupAboutInfoView = {
		let infoView = HTSetupAboutInfoView.init(frame: CGRect.zero)
		return infoView
	}()
	
	lazy var contactView: HTSetupAboutContactView = {
		let contactView = HTSetupAboutContactView.init(frame: CGRect.zero)
		return contactView
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		
	}
	
	func initInterface() {
		navigationItem.title = "关于本软件"
		view.addSubview(infoView)
		view.addSubview(contactView)
		infoView.snp.makeConstraints { (maker) in
			maker.top.left.right.equalTo(0)
		}
		contactView.snp.makeConstraints { (maker) in
			maker.top.equalTo(infoView.snp.bottom)
			maker.left.right.equalTo(0)
			maker.bottom.equalTo(0)
			maker.height.equalTo(88)
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	

}

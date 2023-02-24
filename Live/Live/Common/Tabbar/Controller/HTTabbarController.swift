//
//  HTTabbarController.swift
//  Tian
//
//  Created by hublot on 2018/11/19.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTTabbarController: UITabBarController {

	let modelArray = HTTabbarModel.packModelArray()
		
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		
	}
	
	func initInterface() {
		tabBar.backgroundImage = UIImage.from(UIColor.clear)
		tabBar.shadowImage = UIImage.from(UIColor.init(white: 0, alpha: 0.03))
		tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.init([0xff, 0x63, 0x8a])

		for model in modelArray {
			let controller = model.controllerClass?.init() ?? UIViewController()
			let navigationController = HTNavigationController.init(rootViewController: controller)
			addChildViewController(navigationController)
			let font = UIFont.systemFont(ofSize: 10)
			controller.tabBarItem.setTitleTextAttributes([
				.font: font,
				.foregroundColor: UIColor.init([0x99, 0x99, 0x99])
			], for: .normal)
			controller.tabBarItem.setTitleTextAttributes([
				.font: font,
				.foregroundColor: UIColor.init([0xff, 0x63, 0x8a])
			], for: .selected)
			controller.tabBarItem.title = model.title
			controller.tabBarItem.image = UIImage.init(named: model.image ?? "")?.withRenderingMode(.alwaysOriginal)
			controller.tabBarItem.selectedImage = UIImage.init(named: model.selectedImage ?? "")?.withRenderingMode(.alwaysOriginal)
		}

	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/

	
}

extension HTTabbarController {

	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		guard let index = tabBar.items?.index(of: item), index < modelArray.count else {
			return
		}
		let model = modelArray[index]
		if case .video? = model.type {
			tabBar.barStyle = .black
			tabBar.backgroundImage = UIImage.init(named: "20e2f91e71eaa5f191c3597e578655bc")
		} else {
			tabBar.barStyle = .default
			tabBar.backgroundImage = UIImage.from(UIColor.clear)
		}
	}

}

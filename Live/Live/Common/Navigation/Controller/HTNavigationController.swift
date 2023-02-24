//
//  HTNavigationController.swift
//  Tian
//
//  Created by hublot on 2018/11/19.
//  Copyright © 2018 hublot. All rights reserved.
//

import UIKit
import RTRootNavigationController

class HTNavigationController: RTRootNavigationController {
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		
	}
	
	func initInterface() {
		navigationBar.titleTextAttributes = [
			.font: UIFont.boldSystemFont(ofSize: 17),
			.foregroundColor: UIColor.black
		]
		navigationBar.setBackgroundImage(UIImage.from(UIColor.clear), for: .default)
		navigationBar.shadowImage = UIImage.from(UIColor.init(white: 0, alpha: 0.03))
		navigationBar.isTranslucent = false
		transferNavigationBarAttributes = true
	}
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		viewController.hidesBottomBarWhenPushed = childViewControllers.count > 0
		super.pushViewController(viewController, animated: true)
		
		let backgroundColor = UIColor.white
		if childViewControllers.count > 1 {
			viewController.navigationController?.view.backgroundColor = backgroundColor
		} else {
			viewController.view.backgroundColor = backgroundColor
		}
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/

}


extension RTRootNavigationController {
    
    
    func findController<T: UIViewController>(_ controllerClass: T.Type) -> T? {
        for childController in rt_viewControllers {
            if let controller = childController as? T {
                return controller
            }
        }
        return nil
    }
    
    func findBeforeThisController(_ thisController: UIViewController?) -> UIViewController? {
        for (i, childController) in rt_viewControllers.enumerated() {
            if childController == thisController, i >= 1 {
                return rt_viewControllers[i - 1]
            }
        }
        return nil
    }
    
}


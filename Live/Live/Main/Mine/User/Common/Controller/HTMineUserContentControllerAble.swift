//
//  HTMineUserContentControllerAble.swift
//  Live
//
//  Created by hublot on 2019/1/17.
//  Copyright © 2019 hublot. All rights reserved.
//

import Foundation

protocol HTMineUserContentControllerAble: class {

	typealias HTMineUserPageReloadHeightBlock = ((_: CGFloat) -> Void)

	var uidString: String { get set }

	var reloadSuperControllerHeightBlock: HTMineUserPageReloadHeightBlock? { get set }

	func requestModelArray(_ isHeaderRefresh: Bool)

}

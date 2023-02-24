//
//  HTVideoRefreshAble.swift
//  Live
//
//  Created by hublot on 2019/1/2.
//  Copyright © 2019 hublot. All rights reserved.
//

import Foundation


protocol HTVideoRefreshProtocol: class {
	
	func setRefresh(_ refresh: Bool, animated: Bool)
	
}

protocol HTVideoRefreshController: class {
	
	weak var delegate: HTVideoRefreshProtocol? { get set }
	
}

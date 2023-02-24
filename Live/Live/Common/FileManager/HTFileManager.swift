//
//  HTFileManager.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTFileManager: NSObject {

	static let fileManager = FileManager.default

	static func fileSize(_ path: String) -> Double {
		if let fileSize = try? fileManager.attributesOfItem(atPath: path)[.size] {
			var byteSize = (fileSize as? Double) ?? 0
			// 1000, not 1024
			byteSize /= 1000.0
			byteSize /= 1000.0
			return byteSize
		}
		return 0
	}

	static func floderSize(_ floder: String) -> Double {
		var floderSize: Double = 0
		let nameList = fileManager.subpaths(atPath: floder) ?? [String]()
		for name in nameList {
			let filePath = (floder as NSString).appendingPathComponent(name)
			floderSize += self.fileSize(filePath)
		}
		return floderSize
	}

	static func deleterFloder(_ floder: String) {
		let nameList = fileManager.subpaths(atPath: floder) ?? [String]()
		for name in nameList {
			let filePath = (floder as NSString).appendingPathComponent(name)
			try? fileManager.removeItem(atPath: filePath)
		}
	}

}

//
//  Encrypt.swift
//  Live
//
//  Created by hublot on 2019/1/13.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import CommonCrypto

class Encrypt: NSObject {

	static func md5(_ input: String) -> String {
		let string = input.cString(using: .utf8) ?? [CChar]()
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
		CC_MD5(string, (CC_LONG)(strlen(string)), buffer)
		let output = NSMutableString()
		for i in 0 ..< 16{
			output.appendFormat("%02X", buffer[i])
		}
		free(buffer)
		return output as String
	}

}

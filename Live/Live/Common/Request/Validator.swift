//
//  Validator.swift
//  Shop
//
//  Created by hublot on 2018/3/31.
//  Copyright © 2018年 hublot. All rights reserved.
//

import UIKit
import HTSwift

enum JSONError: LocalizedError {
	case jsonparse
	case validate(_: Int, _: String)
	case willlogin(_: String)
	case noerror(_: Int, _: Any)
	
	var errorDescription: String? {
		return localizedDescription
	}
	
	var localizedDescription: String {
		switch self {
		case .noerror:
			return ""
		case .jsonparse:
			return "JSON 解析失败"
		case .validate(let (_, message)):
			return message
		case .willlogin(let message):
			return message
		}
	}
}

open class JSONParse: ParseProvider {
	
	public func parse(_ session: HTSwift.Session, _ data: Data?, _ error: Error?) -> Result {
		guard error == nil, let data = data else {
			return Result.init(nil, nil, error)
		}
		guard data.count > 0 else {
			return Result.init(data, data, nil)
		}
		guard let object = (try? JSONSerialization.jsonObject(with: data)) else {
			return Result.init(nil, nil, JSONError.jsonparse)
		}
		var reresult = Result.init(data, object, JSONError.noerror(0, object))
		if let dictionary = object as? [String: Any] {
			let value = dictionary["data"]
			let message = dictionary["message"] as? String
			let code = (dictionary["code"] as? Int) ?? 0
			if code != 200, let message = message, message.count > 0 {
				if message.contains("您还没登录!") || message.contains("oken") {
					reresult = Result.init(nil, nil, JSONError.willlogin(message))
				} else {
					reresult = Result.init(nil, nil, JSONError.validate(code, message))
				}
			} else if let value = value {
				reresult = Result.init(data, value, JSONError.noerror(code, object))
			}
		}
		return reresult
	}

}

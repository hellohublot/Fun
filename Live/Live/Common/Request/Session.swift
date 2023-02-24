//
//  Request.swift
//  Shop
//
//  Created by hublot on 2018/3/31.
//  Copyright © 2018年 hublot. All rights reserved.
//

import UIKit
import HTSwift
import HTSwiftNetwork
import Alamofire

open class Session: HTSwift.Session {
	
	public var connector: TaskProvider?
	public var parser: ParseProvider?
	public var cacher: CacheProvider?
	public var stater: StateProvider?
	
	public static var `default`: Session {
		let session = Session()
		return session
	}
	
	open func request(_ string: String, _ method: Alamofire.HTTPMethod = .post, parameter: [String: Any] = [String: Any](), header: [String: String] = [String: String](), _ result: @escaping ResultHandler) {
		var urlstring = string
		var urlparameter = parameter
		if urlparameter.count > 0, case .get = method {
			var components = URLComponents.init(string: urlstring)
			var urlQuery = components?.queryItems ?? [URLQueryItem]()
			for (key, value) in urlparameter {
				let item = URLQueryItem.init(name: key, value: "\(value)")
				urlQuery.append(item)
			}
			components?.queryItems = urlQuery
			urlstring = components?.string ?? urlstring
			urlparameter.removeAll()
		}
		let url = URL.init(string: urlstring) ?? URL.init(fileURLWithPath: "")
		var request = Alamofire.URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
		request.httpMethod = method.rawValue

		let urlEncoding: URLEncoding? = {
			if case .get = method {
				return nil
			} else {
				return URLEncoding.httpBody
			}
		}()
		if let urlEncoding = urlEncoding, let rerequest = try? urlEncoding.encode(request, with: urlparameter) {
			request = rerequest
		}
		for (key, value) in header {
			request.setValue(value, forHTTPHeaderField: key)
		}
		self.handler(request, nil, DispatchQueue.main, result)
	}
	
}

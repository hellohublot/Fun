//
//  Connector.swift
//  Alamofire
//
//  Created by hublot on 2018/3/31.
//

import UIKit
import HTSwift
import Alamofire

open class Task: TaskProvider {
	
	public init() {
		
	}
	
	open weak var session: URLSession?
	
	open var task: URLSessionTask?
	
	open func createTask(_ request: URLRequest, _ progress: ProgressHandler?, _ response: @escaping ResponseHandler) {
		let alamofire =  Alamofire.request(request).downloadProgress(queue: DispatchQueue.global(), closure: { (nsprogress) in
			let complete = Double(nsprogress.completedUnitCount) / 1024.0 / 1024.0
			let total = Double(nsprogress.totalUnitCount) / 1024.0 / 1024.0
			let percent = nsprogress.fractionCompleted
			progress?(percent, complete, total)
		}).responseData(queue: DispatchQueue.global()) { (dataresponse) in
			response(dataresponse.data, dataresponse.error)
		}
		session = alamofire.session
		task = alamofire.task
	}
}

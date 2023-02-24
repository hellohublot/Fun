//
//  Cache.swift
//  Alamofire
//
//  Created by hublot on 2017/12/20.
//

import Foundation
import HTSwift
import HTSQLite

open class Cacher: CacheProvider {
	
	public init() {
		
	}
	
    public static var sandBoxFloder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last ?? ""
	
    public static var cacheFloder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last ?? ""
	
    public static var cacheFilePath = (cacheFloder as NSString).appendingPathComponent("HTSwiftCache.db")
	
    public static var tableName = "networkCache"
	
    public static var createSQL = """
		create table if not exists '\(tableName)' (
			'key' text not null primary key,
			'value' blob not null
		)
	"""
    public static var cacheSQLite: SQLite?
	
    public static func sureSQLiteExist() {
		if FileManager.default.fileExists(atPath: cacheFilePath) == false || cacheSQLite == nil {
			cacheSQLite?.close()
			cacheSQLite = SQLite(path: cacheFilePath, create: createSQL)
		}
	}
	
	open func setCacheNetwork(_ session: Session, _ response: Data?) {
		SQLite.queue.async {
			let this = type(of: self)
			this.sureSQLiteExist()
			let key = self.appendURL(session)
			if key.count > 0, let result = response, result.count > 0 {
				let array = [["key": key, "value": result]] as [[String: AllowValue]]
				this.cacheSQLite?.update(tableName: this.tableName, array: array)
			}
		}
	}
	
	open func cacheNetwork(_ session: Session, _ resultQueue: DispatchQueue, _ result: @escaping CacheResult) {
		SQLite.queue.async {
			let this = type(of: self)
			this.sureSQLiteExist()
			let key = self.appendURL(session)
			var value = Data()
			if key.count > 0 {
				let sql = "select value from '\(this.tableName)' where key = '\(key)'"
				let result = this.cacheSQLite?.execute(SQLBind.init(sql))
				value = result?.first?["value"] ?? Data()
			}
			resultQueue.async {
				result(value)
			}
		}
	}

	open func appendURL(_ session: Session) -> String {
		guard let url = session.connector?.task?.currentRequest?.url?.absoluteString, url.count > 0 else {
			return ""
		}
		guard let method = session.connector?.task?.currentRequest?.httpMethod, method.count > 0 else {
			return ""
		}
		let key = method + " " + url
		return key
	}
	
}

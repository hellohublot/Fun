//
//  HTDiscoverNewsContentModel.swift
//  Live
//
//  Created by hublot on 2019/1/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTDiscoverNewsContentModel: NSObject {
	
	@objc var dynamicid = ""
	@objc var type = ""
	@objc var content = ""
	@objc var addtime = ""
	@objc var os = ""
	@objc var upnum = ""
	@objc var replynum = ""
	@objc var isplay = ""
	@objc var rid = ""
	@objc var roomType = ""
	@objc var isfollow = 1
	@objc var ispraise = 0
	@objc var fanscount = 0
	
	var indexContentAttributedString: NSAttributedString?
	var newsContentAttributedString: NSAttributedString?
	
	var gladContent = ""
	var gladType = ""
		
	@objc var info: HTDiscoverNewsContentInfoModel?
	@objc var photo = [HTDiscoverNewsContentPhotoModel]()
	@objc var comment = [HTDiscoverNewsContentReplyModel]()
	
	override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
		return [
			"info": HTDiscoverNewsContentInfoModel.self,
			"photo": HTDiscoverNewsContentPhotoModel.self,
			"comment": HTDiscoverNewsContentReplyModel.self,
		]
	}
	
	override func mj_keyValuesDidFinishConvertingToObject() {
		indexContentAttributedString = content.packEmojiAttributedStringWithDictionary([
			.font: UIFont.systemFont(ofSize: 12),
			.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
		])
		let newsContentDictionary: [NSAttributedStringKey: Any] = [
			.font: UIFont.systemFont(ofSize: 15),
			.foregroundColor: UIColor.init(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
		]
		newsContentAttributedString = content.packEmojiAttributedStringWithDictionary(newsContentDictionary)
		let maxNewsContentLength = 60
		if (newsContentAttributedString?.length ?? 0) > maxNewsContentLength {
			let attributedString = NSMutableAttributedString.init(attributedString: newsContentAttributedString?.attributedSubstring(from: NSRange.init(location: 0, length: maxNewsContentLength)) ?? NSAttributedString.init())
			attributedString.append(NSAttributedString.init(string: "...", attributes: newsContentDictionary))
			newsContentAttributedString = attributedString
		}
		if type == "4" {
			let data = content.data(using: .utf8) ?? Data()
			let gladDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
			gladContent = gladDictionary??["content"] as? String ?? ""
			gladType = gladDictionary??["type"] as? String ?? ""
		}
	}

}

class HTDiscoverNewsContentInfoModel: NSObject {
	
	@objc var uid = ""
	@objc var nickname = ""
	@objc var headimage = ""
	@objc var webhallposter = ""
	@objc var creditLevel = 0
	
}

class HTDiscoverNewsContentPhotoModel: NSObject {
	
	@objc var id = ""
	@objc var photoname = ""	
	@objc var photothumburl = ""
	@objc var thumbw = 0
	@objc var thumbh = 0
	
}

class HTDiscoverNewsContentReplyModel: NSObject {
	
	@objc var uid = ""
	@objc var nickname = ""
	@objc var isowner = 0
	@objc var commentid = ""
	@objc var addtime = ""
	@objc var curtime = ""
	@objc var headimage = ""
	@objc var guardgid = 0
	@objc var guardLevel = 0
	@objc var manageLevel = 0
	@objc var touid = ""
	@objc var tonickname = ""
	@objc var toisowner = 0
	@objc var toguardgid = 0
	@objc var toguardLevel = 0
	@objc var tomanageLevel = 0
	@objc var content = ""
	@objc var os = ""
	@objc var towealth = 0
	@objc var tostar = 0

	var replyContentAttributedString: NSAttributedString?
	var replyDetailAttributedString: NSAttributedString?

	override func mj_keyValuesDidFinishConvertingToObject() {
		replyContentAttributedString = {
			let attributedString = NSMutableAttributedString.init()
			let normalDictionary: [NSAttributedStringKey: Any] = [
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.init(white: 0.5, alpha: 1)
			]
			let selectedDictionary: [NSAttributedStringKey: Any] = [
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.black
			]
			attributedString.append(NSAttributedString.init(string: nickname, attributes: normalDictionary))
			if tonickname.count > 0 {
				attributedString.append(NSAttributedString.init(string: " 回复 ", attributes: selectedDictionary))
				attributedString.append(NSAttributedString.init(string: tonickname, attributes: normalDictionary))
			}
			attributedString.append(NSAttributedString.init(string: ": ", attributes: normalDictionary))
			attributedString.append(content.packEmojiAttributedStringWithDictionary(selectedDictionary))
			return attributedString
		}()
		replyDetailAttributedString = {
			let attributedString = NSMutableAttributedString.init()
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .left
			paragraphStyle.lineSpacing = 5
			attributedString.append(NSAttributedString.init(string: nickname, attributes: [
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "\n" + addtime, attributes: [
				.font: UIFont.systemFont(ofSize: 12),
				.foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			attributedString.append(NSAttributedString.init(string: "\n", attributes: [
				.paragraphStyle: paragraphStyle
			]))
			if tonickname.count > 0 {
				attributedString.append(NSAttributedString.init(string: "@\(tonickname): ", attributes: [
					.font: UIFont.systemFont(ofSize: 13),
					.foregroundColor: UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1),
					.paragraphStyle: paragraphStyle
				]))
			}
			attributedString.append(content.packEmojiAttributedStringWithDictionary([
				.font: UIFont.systemFont(ofSize: 13),
				.foregroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
				.paragraphStyle: paragraphStyle
			]))
			return attributedString
		}()
	}
	
}









extension String {

	func packEmojiAttributedStringWithDictionary(_ dictionary: [NSAttributedStringKey: Any]) -> NSAttributedString {
		let font = dictionary[.font] as? UIFont ?? UIFont.systemFont(ofSize: 15)
		let attributedString = NSMutableAttributedString.init()
		var componentStringList = components(separatedBy: "[#imgface")
		var emojiStringList = [NSAttributedString]()
		componentStringList = componentStringList.map({ (componentString) -> String in
			guard let normalStartRange = componentString.range(of: "#]") else {
				return componentString
			}
			let normalStartIndex = normalStartRange.upperBound
			let emojiEndIndex = normalStartRange.lowerBound

			let emojiString = String(componentString[componentString.startIndex..<emojiEndIndex])
			guard let emojiImage = UIImage.init(named: "imgface\(emojiString)") else {
				return componentString
			}
			let emojiAttributedString: NSAttributedString = {
				let textAttachment = NSTextAttachment.init()
				textAttachment.image = emojiImage
				textAttachment.bounds = CGRect.init(x: 0, y: (font.ascender + font.descender - emojiImage.size.height) / 2.0, width: emojiImage.size.width, height: emojiImage.size.height)
				let attributedString = NSAttributedString.init(attachment: textAttachment)
				return attributedString
			}()
			emojiStringList.append(emojiAttributedString)
			let normalString = String(componentString[normalStartIndex..<componentString.endIndex])
			return normalString
		})

		for (index, componentString) in componentStringList.enumerated() {
			attributedString.append(NSAttributedString.init(string: componentString, attributes: dictionary))
			if emojiStringList.count > index {
				attributedString.append(emojiStringList[index])
			}
		}
		return attributedString
	}


}

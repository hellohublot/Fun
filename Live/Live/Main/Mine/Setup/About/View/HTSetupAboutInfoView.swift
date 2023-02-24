//
//  HTSetupAboutIconView.swift
//  Live
//
//  Created by hublot on 2019/1/8.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTSetupAboutInfoView: UIView {

	lazy var titleLabel: UILabel = {
		let label = UILabel.init(frame: CGRect.zero)
		label.numberOfLines = 0
		label.attributedText = { 
			let attributedString = NSMutableAttributedString.init()
			let iconImage = UIImage.init(named: "AppIcon")?.imageWith(size: CGSize.init(width: 57, height: 57))
			let attachment = NSTextAttachment.init()
			attachment.image = iconImage
			attachment.bounds = CGRect.init(x: 0, y: 0, width: iconImage?.size.width ?? 0, height: iconImage?.size.height ?? 0)
			attributedString.append(NSAttributedString.init(attachment: attachment))
			attributedString.append(NSAttributedString.init(string: "\n\(Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? "")", attributes: [:]))
			attributedString.append(NSAttributedString.init(string: "\n当前版本: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "")", attributes: [:]))
			attributedString.append(NSAttributedString.init(string: "\nCopyright © \(Calendar.current.dateComponents([.year], from: Date()).year ?? 0) 9xiu.com", attributes: [:]))
			attributedString.append(NSAttributedString.init(string: "\nInc.All Rights Reserved.", attributes: [:]))
			let paragraphStyle = NSMutableParagraphStyle.init()
			paragraphStyle.alignment = .center
			paragraphStyle.lineSpacing = 20
			attributedString.addAttributes([
				.foregroundColor: UIColor.black,
				.font: UIFont.systemFont(ofSize: 13),
				.paragraphStyle: paragraphStyle,
			], range: NSRange.init(location: 0, length: attributedString.length))
			return attributedString
		}()
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { (maker) in
			maker.left.right.equalTo(0)
			maker.centerY.equalTo(self).offset(-20)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

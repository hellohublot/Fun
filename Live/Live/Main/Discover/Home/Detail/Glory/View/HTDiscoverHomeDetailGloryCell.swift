//
//  HTDiscoverHomeDetailGloryCell.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailGloryCell: UITableViewCell, ReuseCell {
    
    lazy var whiteContentView: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var footerTitleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        addSubview(whiteContentView)
        addSubview(headerImageView)
        addSubview(footerTitleLabel)
        whiteContentView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
        }
        headerImageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.top.equalTo(30)
            maker.bottom.equalTo(footerTitleLabel.snp.top).offset(-10)
        }
        footerTitleLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(whiteContentView).offset(-20)
            maker.centerX.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: Any?, for indexPath: IndexPath) {
        guard let model = model as? HTDiscoverHomeDetailGloryModel else {
            return
        }
        headerImageView.image = UIImage.init(named: model.image ?? "")
        footerTitleLabel.attributedText = {
            let attributedString = NSMutableAttributedString.init()
            attributedString.append(NSAttributedString.init(string: model.title ?? "", attributes: [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
            ]))
            attributedString.append(NSAttributedString.init(string: "第", attributes: [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
            ]))
            attributedString.append(NSAttributedString.init(string: " \(model.text ?? "") ", attributes: [
                .font: UIFont.systemFont(ofSize: 23),
                .foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
            ]))
            attributedString.append(NSAttributedString.init(string: "名", attributes: [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.init(red: 1, green: 0.388235, blue: 0.541176, alpha: 1)
            ]))
            return attributedString
        }()
    }

}

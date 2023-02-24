//
//  HTLiveFollowSectionPlaceholderView.swift
//  Live
//
//  Created by hublot on 2019/1/28.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTLiveFollowSectionPlaceholderView: UICollectionReusableView, ReuseCell {
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleImageView)
        addSubview(titleLabel)
        titleImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(30)
            maker.width.height.equalTo(140)
        }
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self)
            maker.top.equalTo(titleImageView.snp.bottom).offset(10)
            maker.left.equalTo(15)
            maker.right.equalTo(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: Any?, for indexPath: IndexPath) {
        guard let _ = model as? HTLiveFollowSectionModel else {
            return
        }
        var titleName = ""
        var imageName = ""
        if HTUserAuthManager.isLogin() {
            titleName = "暂无关注的主播开播，看看推荐吧~"
            imageName = "19a4a5fac1b38540239ce5ead92b29eb"
        } else {
            titleName = "登录关注您喜爱的主播吧~"
            imageName = "2fe0756a40dcc722add66c1fe119d31d"
        }
        titleImageView.image = UIImage.init(named: imageName)
        titleLabel.text = titleName
    }
    
}

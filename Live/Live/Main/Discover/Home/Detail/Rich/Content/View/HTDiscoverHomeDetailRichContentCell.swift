//
//  HTDiscoverHomeDetailRichContentCell.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverHomeDetailRichContentCell: UITableViewCell, ReuseCell {
    
    lazy var rankImageButton: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        return button
    }()

    lazy var rankTitleButton: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.setBackgroundImage(UIImage.from(UIColor.init(red: 1, green: 0.39, blue: 0.54, alpha: 1)), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3
        return button
    }()
    
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2.0
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rankTitleButton)
        addSubview(rankImageButton)
        addSubview(headImageView)
        addSubview(nicknameLabel)
        rankTitleButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(15)
            maker.centerY.equalTo(self)
            maker.width.height.equalTo(20)
        }
        rankImageButton.snp.makeConstraints { (maker) in
            maker.center.equalTo(rankTitleButton)
        }
        headImageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(rankTitleButton.snp.right).offset(15)
            maker.centerY.equalTo(self)
            maker.width.height.equalTo(40)
        }
        nicknameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(headImageView.snp.right).offset(15)
            maker.centerY.equalTo(self)
            maker.right.equalTo(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: Any?, for indexPath: IndexPath) {
        guard let model = model as? HTMineUserInfoModel else {
            return
        }
        if indexPath.row < 3 {
            rankImageButton.isHidden = false
            rankTitleButton.isHidden = true
        } else {
            rankImageButton.isHidden = true
            rankTitleButton.isHidden = false
        }
        switch indexPath.row {
        case 0:
            rankImageButton.setImage(UIImage.init(named: "b7709eccc57140b9a9ff65449be5c559"), for: .normal)
        case 1:
            rankImageButton.setImage(UIImage.init(named: "1e9b513bc4ba46534a21f10889648d1e"), for: .normal)
        case 2:
            rankImageButton.setImage(UIImage.init(named: "157c965949cd87c2adcb675e833b38ac"), for: .normal)
        default:
            rankTitleButton.setTitle("\(indexPath.row + 1)", for: .normal)
        }
        headImageView.kf.setImage(with: Request.url(model.headimage), placeholder: Request.placeImage)
        nicknameLabel.text = model.nickname
    }

}

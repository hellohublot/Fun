//
//  HTDiscoverRankPopCell.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTSwift

class HTDiscoverRankPopCell: UITableViewCell, ReuseCell {
    
    lazy var titleButton: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        button.ht_makeEdge(with: .horizontal, imageToTitleaOffset: 15)
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIImageView.init(image: UIImage.from(UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)))
        addSubview(titleButton)
        titleButton.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: Any?, for indexPath: IndexPath) {
        guard let model = model as? HTDiscoverRankPopModel else {
            return
        }
        titleButton.setImage(UIImage.init(named: model.image ?? ""), for: .normal)
        titleButton.setTitle(model.title, for: .normal)
    }

}

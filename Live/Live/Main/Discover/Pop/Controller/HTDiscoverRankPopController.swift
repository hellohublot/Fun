//
//  HTDiscoverRankPopController.swift
//  Live
//
//  Created by hublot on 2019/2/21.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTMaskView

class HTDiscoverRankPopController: NSObject {
    
    static func showRankPopModelArray(_ modelArray: [HTDiscoverRankPopModel], _ rankPopSelected: HTDiscoverRankPopView.HTDiscoverRankPopSelected?) {
        let popView = HTDiscoverRankPopView.init(frame: CGRect.zero)
        popView.setModelArray(modelArray)
        let popHeight = modelArray.count * 45 + 5
        let maskView = HTMaskView.init(contentView: popView)
        popView.snp.makeConstraints { (maker) in
            maker.right.equalTo(-10)
            maker.top.equalTo(HTStatic.statusHeight + (HTStatic.navigationHeight - HTStatic.statusHeight) / 2.0 + 20)
            maker.width.equalTo(140)
            maker.height.equalTo(popHeight)
        }
        let transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        maskView?.present(animated: true, ifpresentTransform: transform, ifdismissTransform: transform, complete: { (maskView) in
            
        }, backgroundTouchInside: { (maskView) in
            maskView?.dismissWith(animated: true, complete: nil)
        })
        popView.rankPopSelected = { [weak maskView] (modelArray, index, selectedModel) in
            maskView?.dismissWith(animated: true, complete: nil)
            rankPopSelected?(modelArray, index, selectedModel)
        }
    }

}

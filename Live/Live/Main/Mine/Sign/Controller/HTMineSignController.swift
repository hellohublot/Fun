//
//  HTMineSignController.swift
//  Live
//
//  Created by hublot on 2019/2/11.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import HTMaskView

class HTMineSignController: UIViewController {

	static func showUserSignView() {
		let contentView = HTMineSignView.init(frame: CGRect.zero)
		let modelArray = HTMineSignModel.packModelArray()
		contentView.setModel(modelArray, for: IndexPath.init())

		let maskView = HTMaskView.init(contentView: contentView)
		maskView?.duration = 0.5
		maskView?.usingSpringWithDamping = 0.65
		maskView?.initialSpringVelocity = 0

		contentView.snp.makeConstraints { (maker) in
			maker.width.equalTo(320)
			if let maskView = maskView {
				maker.center.equalTo(maskView)
			}
			maker.height.equalTo(400)
		}
		contentView.dismissButton.whenTouch(inside: { [weak maskView] (_, _) in
			maskView?.dismissWith(animated: true, complete: nil)
		}, receive: nil)
		maskView?.present(animated: true, ifpresentTransform: CGAffineTransform.init(scaleX: 0, y: 0), ifdismissTransform: CGAffineTransform.init(scaleX: 1.4, y: 1.4), complete: nil, backgroundTouchInside: { (maskView) in
			maskView?.dismissWith(animated: true, complete: nil)
		})
	}

}

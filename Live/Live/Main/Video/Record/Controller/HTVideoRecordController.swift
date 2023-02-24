//
//  HTVideoRecordController.swift
//  Live
//
//  Created by hublot on 2019/1/4.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit
import GPUImage

class HTVideoRecordController: UIViewController {
	
	lazy var videoCamera: GPUImageVideoCamera? = {
		let videoCamera = GPUImageVideoCamera.init(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .back)
		videoCamera?.outputImageOrientation = .portrait
		videoCamera?.horizontallyMirrorFrontFacingCamera = true
		videoCamera?.horizontallyMirrorRearFacingCamera = false
		videoCamera?.addTarget(videoFilter)
		return videoCamera
	}()
	
	lazy var videoFilter: GPUImageFilter = {
		let videoFilter = HTVideoRecordBeautyFilter.init()
		videoFilter.addTarget(videoImageView)
		return videoFilter
	}()
	
	lazy var videoImageView: GPUImageView = {
		let imageView = GPUImageView.init(frame: CGRect.zero)
		return imageView
	}()
	
	lazy var navigationBar: HTVideoRecordNavigationBar = {
		let navigationBar = HTVideoRecordNavigationBar.init(frame: CGRect.zero)
		return navigationBar
	}()
	
	lazy var toolBar: HTVideoRecordToolBar = {
		let toolBar = HTVideoRecordToolBar.init(frame: CGRect.zero)
		return toolBar
	}()
	
	lazy var tabBar: HTVideoRecordTabBar = {
		let tabBar = HTVideoRecordTabBar.init(frame: CGRect.zero)
		return tabBar
	}()
	
	/*-------------------------------------/ init /-----------------------------------*/
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initDataSource()
		initInterface()
	}
	
	func initDataSource() {
		videoCamera?.startCapture()
		navigationBar.positionButton.whenTouch(inside: { [weak self] (_, _) in
			self?.videoCamera?.rotateCamera()
		}, receive: nil)
	}
	
	func initInterface() {
		view.backgroundColor = UIColor.black
		view.addSubview(videoImageView)
		view.addSubview(navigationBar)
		view.addSubview(toolBar)
		view.addSubview(tabBar)
		videoImageView.snp.makeConstraints { (maker) in
			maker.edges.equalTo(UIEdgeInsets.zero)
		}
		navigationBar.snp.makeConstraints { (maker) in
			maker.left.top.right.equalTo(0)
			maker.height.equalTo(HTStatic.navigationHeight)
		}
		toolBar.snp.makeConstraints { (maker) in
			maker.right.equalTo(0)
			maker.width.equalTo(50)
			maker.height.equalTo(250)
			maker.bottom.equalTo(tabBar.snp.top)
		}
		tabBar.snp.makeConstraints { (maker) in
			maker.height.equalTo(130)
			maker.left.right.equalTo(0)
            maker.bottom.equalTo(-HTStatic.tabbarHeight + 49)
		}
		view.layoutIfNeeded()
		let speedModelArray = HTVideoRecordSpeedModel.packModelArray()
		tabBar.whiteCollectionView.setCellModelArray(speedModelArray, proxy: tabBar)
		tabBar.blackCollectionView.setCellModelArray(speedModelArray, proxy: tabBar)
		tabBar.collectionView(tabBar.whiteCollectionView, didSelectItemAt: IndexPath.init(row: 2, section: 0))
	}
	
	/*-------------------------------------/ controller override /-----------------------------------*/
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarHidden(true, with: .slide)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarHidden(false, with: .slide)
	}

}

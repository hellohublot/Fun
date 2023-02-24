//
//  HTLiveNearLocationManager.swift
//  Live
//
//  Created by hublot on 2019/2/1.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTLiveNearLocationManager: NSObject {

	static let locationNotification = NSNotification.Name.init("com.hublot.locationChangeNotification")

	lazy var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager.init()
		locationManager.delegate = self
		return locationManager
	}()

	func startUpdatingLocation() {
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}

	static var locationAuthorization: Bool {
		get {
			return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
		}
	}

	static var locationProvinceName = ""

}

extension HTLiveNearLocationManager: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}
		manager.stopUpdatingLocation()
		let geocoder = CLGeocoder.init()
		geocoder.reverseGeocodeLocation(location) { (placeMarkList, error) in
			guard let placeMark = placeMarkList?.first, let addressProvince = placeMark.administrativeArea ?? placeMark.locality else {
				return
			}
			type(of: self).locationProvinceName = addressProvince
			type(of: self).sendSelectedOrLocationNotification()
		}
	}

	static func sendSelectedOrLocationNotification() {
		NotificationCenter.default.post(name: locationNotification, object: nil)
	}

}

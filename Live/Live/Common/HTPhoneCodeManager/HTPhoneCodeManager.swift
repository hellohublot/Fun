//
//  HTPhoneCodeManager.swift
//  Live
//
//  Created by hublot on 2019/2/18.
//  Copyright © 2019 hublot. All rights reserved.
//

import UIKit

class HTPhoneCodeManager: NSObject {
    
    static let share = HTPhoneCodeManager()
    
    var timer: Timer?
    
    @objc dynamic var phoneCodeCount = 0
    
    @objc func phoneCodeTimerSelector() {
        phoneCodeCount -= 1
        if phoneCodeCount <= 0 {
            timer?.invalidate()
        }
    }
    
    func requestPhoneButtonCode() {
        guard phoneCodeCount <= 0 else {
            return
        }
        self.timer?.invalidate()
    }
    
    func responsePhoneButtonCode(_ phoneCodeTime: Int?) {
        guard let phoneCodeTime = phoneCodeTime else {
            phoneCodeCount = 0
            return
        }
        timer?.invalidate()
        phoneCodeCount = phoneCodeTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.phoneCodeTimerSelector), userInfo: nil, repeats: true)
    }


}

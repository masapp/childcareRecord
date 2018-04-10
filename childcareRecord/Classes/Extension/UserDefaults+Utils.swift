//
//  UserDefaults+Utils.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    var isNotificationEnabled: Bool {
        get {
            return self.bool(forKey: "notification")
        }
        set(value) {
            self.set(value, forKey: "notification")
            self.synchronize()
        }
    }
    
    var interval: Int {
        get {
            return self.integer(forKey: "interval")
        }
        set(value) {
            self.set(value, forKey: "interval")
            self.synchronize()
        }
    }
}

//
//  UserDefaults+Utils.swift
//  childcareRecord
//
//  Created by masapp on 2018/04/10.
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
    
    var lastUpdateTime: String {
        get {
            return self.string(forKey: "lastUpdate") ?? ""
        }
        set(value) {
            self.set(value, forKey: "lastUpdate")
            self.synchronize()
        }
    }
    
    var beforeUpdateTime: String {
        get {
            return self.string(forKey: "beforeUpdate") ?? ""
        }
        set(value) {
            self.set(value, forKey: "beforeUpdate")
            self.synchronize()
        }
    }
    
    func getHistory(key: String) -> [String] {
        return self.array(forKey: key) as? [String] ?? []
    }
    
    func setHistory(key: String, value: [String]) {
        self.set(value, forKey: key)
        self.synchronize()
    }
}

//
//  NotificationSettingCell.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationSettingCell: UITableViewCell {
    
    @IBOutlet var notiSwitch: UISwitch!
    
    private let defaults = UserDefaults.standard
    
    // MARK: - internal
    func setup() {
        notiSwitch.isOn = defaults.isNotificationEnabled
        notiSwitch.addTarget(self, action: #selector(changeSwitch(_:)), for: .valueChanged)
    }
    
    // MARK: - @objc function
    @objc private func changeSwitch(_ sender: UISwitch) {
        defaults.isNotificationEnabled = sender.isOn
        NotificationCenter.default.post(name: .switchChange, object: nil)
        
        if !sender.isOn {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
}

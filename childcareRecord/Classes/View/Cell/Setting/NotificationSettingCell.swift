//
//  NotificationSettingCell.swift
//  childcareRecord
//
//  Created by masapp on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationSettingCell: UITableViewCell {
    
    @IBOutlet var notiSwitch: UISwitch!
    @IBOutlet var titleLabel: UILabel!
    
    private let defaults = UserDefaults.standard
    
    // MARK: - internal
    func setup() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .denied:
                self.disabled()
            case .notDetermined:
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                    if error != nil {
                        return
                    }
                    
                    if granted {
                        self.enabled()
                    } else {
                        self.disabled()
                    }
                })
            case .authorized:
                self.enabled()
            }
        }
    }
    
    // MARK: - @objc function
    @objc private func changeSwitch(_ sender: UISwitch) {
        self.defaults.isNotificationEnabled = sender.isOn
        NotificationCenter.default.post(name: .switchChange, object: nil)
        
        if !sender.isOn {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    // MARK: - private
    private func enabled() {
        DispatchQueue.main.async {
            self.notiSwitch.isOn = self.defaults.isNotificationEnabled
            self.notiSwitch.addTarget(self, action: #selector(self.changeSwitch(_:)), for: .valueChanged)
        }
    }
    
    private func disabled() {
        DispatchQueue.main.async {
            self.defaults.isNotificationEnabled = false
            self.notiSwitch.isOn = false
            self.isUserInteractionEnabled = false
            self.titleLabel.isEnabled = false
            self.notiSwitch.isEnabled = false
            NotificationCenter.default.post(name: .switchChange, object: nil)
        }
    }
}

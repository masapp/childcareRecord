//
//  IntervalSettingCell.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit

class IntervalSettingCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var intervalLabel: UILabel!
    
    private let defaults = UserDefaults.standard
    
    // MARK: - internal
    func setup(_ pickerList: [String]) {
        intervalLabel.text = pickerList[defaults.interval]
        
        changeEnabled(isEnabled: defaults.isNotificationEnabled)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: .switchChange, object: nil, queue: OperationQueue.main, using: { _ in
            self.changeEnabled(isEnabled: self.defaults.isNotificationEnabled)
        })
        notificationCenter.addObserver(forName: .pickerChange, object: nil, queue: OperationQueue.main, using: { _ in
            self.intervalLabel.text = pickerList[self.defaults.interval]
        })
    }
    
    // MARK: - private
    private func changeEnabled(isEnabled: Bool) {
        isUserInteractionEnabled = isEnabled
        titleLabel.isEnabled = isEnabled
        intervalLabel.isEnabled = isEnabled
    }
}

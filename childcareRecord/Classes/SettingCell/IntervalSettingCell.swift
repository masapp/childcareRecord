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
        
//        if !defaults.isNotificationEnabled {
//            isUserInteractionEnabled = false
//            titleLabel.isEnabled = false
//            intervalLabel.isEnabled = false
//        }
    }
}

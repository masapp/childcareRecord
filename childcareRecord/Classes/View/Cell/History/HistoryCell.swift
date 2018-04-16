//
//  HistoryCell.swift
//  childcareRecord
//
//  Created by masapp on 2018/04/11.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    
    // MARK: - internal
    func setup(_ time: String) {
        timeLabel.text = time
    }
}

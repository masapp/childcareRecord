//
//  SettingViewController.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var closeButton: UIBarButtonItem!
    
    private let pickerList = [
        "1hour", "2hour", "3hour", "4hour", "5hour", "6hour"
    ]
    private let defaults = UserDefaults.standard
    private var numRows = 2
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        tableView.dataSource = self
        tableView.delegate = self
        
        closeButton.target = self
        closeButton.action = #selector(onTapClose)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notification") as! NotificationSettingCell
            cell.setup()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "interval") as! IntervalSettingCell
            cell.setup(pickerList)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickerView") as! PickerViewCell
            cell.setup(pickerList)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let pickerIndexPath = IndexPath(row: 2, section: 0)
            if numRows == 2 {
                numRows = 3
                tableView.insertRows(at: [pickerIndexPath], with: .automatic)
                let pickerCell = tableView.cellForRow(at: pickerIndexPath) as! PickerViewCell
                pickerCell.pickerView.selectRow(defaults.interval, inComponent: 0, animated: false)
            } else {
                numRows = 2
                let intervalCell = tableView.cellForRow(at: indexPath) as! IntervalSettingCell
                intervalCell.intervalLabel.text = pickerList[defaults.interval]
                tableView.deleteRows(at: [pickerIndexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 90
        }
        return 44
    }
    
    // MARK: - @objc function
    @objc private func onTapClose() {
        dismiss(animated: true, completion: nil)
    }
}

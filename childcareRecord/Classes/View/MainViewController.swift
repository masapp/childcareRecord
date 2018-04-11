//
//  MainViewController.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMobileAds

class MainViewController: UIViewController {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var milkButton: UIButton!
    @IBOutlet var milkView: UIView!
    @IBOutlet var milkHistoryButton: UIButton!
    @IBOutlet var milkCountLabel: UILabel!
    @IBOutlet var milkTimeLabel: UILabel!
    @IBOutlet var diapersButton: UIButton!
    @IBOutlet var diapersView: UIView!
    @IBOutlet var diapersHistoryButton: UIButton!
    @IBOutlet var diapersCountLabel: UILabel!
    @IBOutlet var diapersTimeLabel: UILabel!
    
    private let defaults = UserDefaults.standard
    private var today = ""
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        setup()
        setMilkLabel()
        setDiapersLabel()
        
        today = getToday()
        let lastUpdateTime = defaults.lastUpdateTime
        // 日付の更新
        if today != lastUpdateTime {
            defaults.setHistory(key: "beforeMilk", value: defaults.getHistory(key: "beforeMilk"))
            defaults.setHistory(key: "beforeDiapers", value: defaults.getHistory(key: "beforeDiapers"))
            defaults.setHistory(key: "todayMilk", value: [])
            defaults.setHistory(key: "todayDiapers", value: [])
            defaults.beforeUpdateTime = defaults.lastUpdateTime
            defaults.lastUpdateTime = today
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - @objc function
    @objc private func onTapSettingButton() {
        let settingVC = storyboard?.instantiateViewController(withIdentifier: "settingVC") as! SettingViewController
        present(settingVC, animated: true, completion: nil)
    }
    
    @objc private func onTapMilkHistoryButton() {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: "historyVC") as! HistoryViewController
        historyVC.setup("Milk")
        present(historyVC, animated: true, completion: nil)
    }
    
    @objc private func onTapDiapersHistoryButton() {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: "historyVC") as! HistoryViewController
        historyVC.setup("Diapers")
        present(historyVC, animated: true, completion: nil)
    }
    
    @objc private func onTapMilkButton() {
        var history = defaults.getHistory(key: "todayMilk")
        history.insert(getNowTime(), at: 0)
        defaults.setHistory(key: "todayMilk", value: history)
        
        setMilkLabel()
        
        if defaults.isNotificationEnabled {
            setLocalNotification()
        }
    }
    
    @objc private func onTapDiapersButton() {
        var history = defaults.getHistory(key: "todayDapers")
        history.insert(getNowTime(), at: 0)
        defaults.setHistory(key: "todayDiapers", value: history)
        
        setDiapersLabel()
    }
    
    // MARK: - private
    private func setup() {
        milkView.layer.cornerRadius = 10
        milkView.layer.borderColor = UIColor.hexStr(hexStr: "ffddbc", alpha: 100).cgColor
        milkView.layer.borderWidth = 5
        milkHistoryButton.addTarget(self, action: #selector(onTapMilkHistoryButton), for: .touchUpInside)
        milkButton.addTarget(self, action: #selector(onTapMilkButton), for: .touchUpInside)
        
        diapersView.layer.cornerRadius = 10
        diapersView.layer.borderColor = UIColor.hexStr(hexStr: "ffddbc", alpha: 100).cgColor
        diapersView.layer.borderWidth = 5
        diapersHistoryButton.addTarget(self, action: #selector(onTapDiapersHistoryButton), for: .touchUpInside)
        diapersButton.addTarget(self, action: #selector(onTapDiapersButton), for: .touchUpInside)
        
        settingButton.addTarget(self, action: #selector(onTapSettingButton), for: .touchUpInside)
    }
    
    private func setMilkLabel() {
        let history = defaults.getHistory(key: "todayMilk")
        milkCountLabel.text = String(history.count)
        milkTimeLabel.text = history.count > 0 ? history[0] : "--:-- AM"
    }
    
    private func setDiapersLabel() {
        let history = defaults.getHistory(key: "todayDiapers")
        diapersCountLabel.text = String(history.count)
        diapersTimeLabel.text = history.count > 0 ? history[0] : "--:-- AM"
    }
    
    private func getToday() -> String {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .none
        return f.string(from: Date())
    }
    
    private func getNowTime() -> String {
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .short
        return f.string(from: Date())
    }
    
    private func setLocalNotification() {
        let interval = defaults.interval + 1
        let content = UNMutableNotificationContent()
        content.title = NotificationSettings.title
        content.body = "\(interval) \(NotificationSettings.body)"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval * 60 * 60), repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNoti", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

//
//  HistoryViewController.swift
//  childcareRecord
//
//  Created by masapp on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var closeButton: UIBarButtonItem!
    @IBOutlet var historyNavigationItem: UINavigationItem!
    
    private let defaults = UserDefaults.standard
    
    private var navigationTitle = ""
    private var sectionTitles: [String] = []
    private var todayHistories: [String] = []
    private var beforeHistories: [String] = []
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        closeButton.target = self
        closeButton.action = #selector(onTapClose)
        
        historyNavigationItem.title = navigationTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return todayHistories.count
        case 1:
            return beforeHistories.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history") as! HistoryCell
        switch indexPath.section {
        case 0:
            cell.setup(todayHistories[indexPath.row])
        case 1:
            cell.setup(beforeHistories[indexPath.row])
        default:
            cell.setup("--:-- AM")
        }

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - @objc function
    @objc private func onTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - internal
    func setup(_ type: String) {
        todayHistories = defaults.getHistory(key: "today\(type)")
        beforeHistories = defaults.getHistory(key: "before\(type)")
        sectionTitles = [defaults.lastUpdateTime, defaults.beforeUpdateTime]
        
        navigationTitle = NSLocalizedString(type, comment: "")
    }
}

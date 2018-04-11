//
//  HistoryViewController.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HistoryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var closeButton: UIBarButtonItem!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        tableView.dataSource = self
        
        closeButton.target = self
        closeButton.action = #selector(onTapClose)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - @objc function
    @objc private func onTapClose() {
        dismiss(animated: true, completion: nil)
    }
}

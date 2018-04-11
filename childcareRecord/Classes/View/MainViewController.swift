//
//  MainViewController.swift
//  childcareRecord
//
//  Created by 石川 雅之 on 2018/04/10.
//  Copyright © 2018 masapp. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var historyButton: UIButton!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        settingButton.addTarget(self, action: #selector(onTapSettingButton), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(onTapHistoryButton), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - @objc function
    @objc private func onTapSettingButton() {
        let settingVC = storyboard?.instantiateViewController(withIdentifier: "settingVC") as! SettingViewController
        present(settingVC, animated: true, completion: nil)
    }
    
    @objc private func onTapHistoryButton() {
        let historyVC = storyboard?.instantiateViewController(withIdentifier: "historyVC") as! HistoryViewController
        present(historyVC, animated: true, completion: nil)
    }
}

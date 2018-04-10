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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = AdSettings.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//
//  ViewController.swift
//  Daily Dose
//
//  Created by Thomas Pickup on 24/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

// Imports
import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var btnRemoveAds: UIButton!
    @IBOutlet weak var btnRestoreAds: UIButton!
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) == false {
            setUpAds()
        } else {
            removeAdView()
        }
    }

    // Actions
    @IBAction func onRestorePressed(_ sender: Any) {
        PurchaseManager.instance.restoreRemoveAds { (success) in
            if (success) {
                self.removeAdView()
            }
        }
    }
    
    @IBAction func onRemoveAdsPressed(_ sender: Any) {
        PurchaseManager.instance.purchaseRemoveAds { (success) in
            if (success) {
                self.removeAdView()
            }
        }
    }
    
    // Functions
    func removeAdView() {
        bannerView.removeFromSuperview()
        btnRemoveAds.removeFromSuperview()
    }
    
    func setUpAds() {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
}


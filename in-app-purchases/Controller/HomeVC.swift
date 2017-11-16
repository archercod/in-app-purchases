//
//  ViewController.swift
//  in-app-purchases
//
//  Created by Marcin Pietrzak on 15/11/2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAds()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAds() {
        if UserDefaults.standard.bool(forKey: PurchasesManager.instance.IAP_REMOVE_ADS) == true {
            
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
        } else {
            
            removeAdsButton.removeFromSuperview()
            bannerView.removeFromSuperview()
            
        }
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        
        PurchasesManager.instance.restorePurchases { (success) in
            if success {
                self.setupAds()
            }
        }
        
    }
    
    @IBAction func remoceAdsPressed(_ sender: Any) {
        
        //TODO: show loading spinner
        PurchasesManager.instance.purchasesRemoveAds { (success) in
            //dismiss spinner
            if success {
                self.bannerView.removeFromSuperview()
                self.removeAdsButton.removeFromSuperview()
            } else {
                //show message to the user
            }
        }
        
    }
    


}


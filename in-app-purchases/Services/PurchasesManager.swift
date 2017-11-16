//
//  PurchasesManager.swift
//  in-app-purchases
//
//  Created by Marcin Pietrzak on 16/11/2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation
import StoreKit

class PurchasesManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let instance = PurchasesManager()
    
    let IAP_REMOVE_ADS = "com.devslopes.daily.dose.remove.ads"
    
    var productsRequests: SKProductsRequest!
    var products = [SKProduct]()
    
    func fetchProducts() {
        let productIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productsRequests = SKProductsRequest(productIdentifiers: productIds)
        productsRequests.delegate = self
        productsRequests.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        <#code#>
    }
    
}

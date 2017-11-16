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
    
    func purchasesRemoveAds() {
        
        //Check paymant is available
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment) //start processing payment request
        }
        
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .purchased:
            SKPaymentQueue.default().finishTransaction(transaction)
            if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
            }
                break
            case .failed:
            SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .restored:
            SKPaymentQueue.default().finishTransaction(transaction)
            default: break
                
            }
            
        }
        
    }
    
}

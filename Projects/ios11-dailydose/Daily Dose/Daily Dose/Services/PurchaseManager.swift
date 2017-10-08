//
//  PurchaseManager.swift
//  Daily Dose
//
//  Created by Thomas Pickup on 02/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

// Type Alias
typealias CompletionHandler = (_ success: Bool) -> ()

// Imports
import Foundation
import StoreKit

class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    // Variables
    static let instance = PurchaseManager()
    let IAP_REMOVE_ADS = "uk.co.thomaspickup.dailydose.removeads"
    var productsRequests: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: CompletionHandler?
    
    // Functions
    func fetchProducts() {
        // Creates list of product ids to fetch
        let productIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        
        // Creates a request and sends it
        productsRequests = SKProductsRequest(productIdentifiers: productIds)
        productsRequests.delegate = self
        productsRequests.start()
    }
    
    func purchaseRemoveAds(onComplete: @escaping CompletionHandler) {
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = onComplete
            
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            onComplete(false)
        }
    }
    
    func setRemovedAds() {
        UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
    }
    
    func restoreRemoveAds(onComplete: @escaping CompletionHandler) {
        if SKPaymentQueue.canMakePayments() {
            transactionComplete = onComplete
            
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            onComplete(false)
        }
    }
    // Protocols
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // If reponse contains products store them in products array
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
                    setRemovedAds()
                    transactionComplete?(true)
                }
                
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                transactionComplete?(false)
                
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                    setRemovedAds()
                    transactionComplete?(true)
                }
                
                break
            default:
                transactionComplete?(false)
                
                break
            }
        }
    }
}

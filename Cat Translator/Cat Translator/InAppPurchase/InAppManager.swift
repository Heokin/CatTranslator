//
//  InAppPurchase.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import StoreKit
import SwiftyStoreKit

enum RegisterPurchase: String {
    
    case weekTrial = "1wetr"
    case week = "1we"
    case mounth = "1mo"
    case mounthTrial = "1motr"
    case year = "1ye"
    case yearTrial = "1yetr"
    
}

class NetworkActivityIndicatorManager : NSObject {
    
    private static var loadingCount = 0
    
    class func NetworkOperationStarted() {
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    class func networkOperationFinished(){
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

class IAPManager: UIViewController {
    
    let bundleID = "com.cattranslator"
    let sharedSecret = "32c6bf09088c40d3b5db631004b09ff9"
    static let shared = IAPManager()
    let local = LocalizationVariables()
    
    var weekTrial = RegisterPurchase.weekTrial
    var week = RegisterPurchase.week
    var mounth = RegisterPurchase.mounth
    var mounthTrial = RegisterPurchase.mounthTrial
    var year = RegisterPurchase.year
    var yearTrial = RegisterPurchase.yearTrial
    
    func getInfo(purchase : RegisterPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
        })
    }
    
    func purchase(purchase : RegisterPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue, quantity: 1, atomically: true) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                    let access = true
                    UserDefaults.standard.set(access, forKey: "FullAccess")
                }
                let access = true
                UserDefaults.standard.set(access, forKey: "FullAccess")
                NotificationCenter.default.post(name: Notification.Name("SubscribeOk"), object: nil)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
        
    }
    
    
    func restorePurchases() {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                NotificationCenter.default.post(name: Notification.Name("RestoreError"), object: nil)
            }
            else if results.restoredPurchases.count > 0 {
                let accesss = true
                UserDefaults.standard.set(accesss, forKey: "FullAccess")
                NotificationCenter.default.post(name: Notification.Name("SubscribeOk"), object: nil)
            }
            else {
                NotificationCenter.default.post(name: Notification.Name("RestoreError"), object: nil)
            }
        }
        
    }
    
    func restoreTarget() {
        let alertController = UIAlertController(title: local.alertRestore,
                                                message: local.alertRestoreDiscription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: local.alertOk, style: .destructive))
        alertController.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        self.present(alertController, animated: true)
    }
    
    func fetchUpdatedReciept(){
        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
            switch result {
            case .success(let receiptData):
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                print("Fetch receipt success:\n\(encryptedReceipt)")
                
            case .error(let error):
                print("Fetch receipt failed: \(error)")
            }
        }
    }
    
    func verifyReceipt() {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            switch result {
            case .success(let receipt):
                print("Verify receipt success: \(receipt)")
                let access = true
                //NotificationCenter.default.post(name: Notification.Name("SubscribeOkAuto"), object: nil)
                UserDefaults.standard.set(access, forKey: "FullAccess")
                
            case .error(let error):
                print("Verify receipt failed: \(error)")
                let accesss = false
                UserDefaults.standard.set(accesss, forKey: "FullAccess")
                
                self.fetchUpdatedReciept()
            }
        }
    }
    
    
    func verifyPurcahse(product : RegisterPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            switch result {
            case .success(let receipt):
                let productId = self.bundleID + "." + product.rawValue
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable, // or .nonRenewing (see below)
                    productId: productId,
                    inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productId) is valid until \(expiryDate)\n\(items)\n")
                    let access = 1
                    UserDefaults.standard.set(access, forKey: "FullAccess")
                case .expired(let expiryDate, let items):
                    let access = false
                    UserDefaults.standard.set(access, forKey: "FullAccess")
                    print("\(productId) is expired since \(expiryDate)\n\(items)\n")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                self.fetchUpdatedReciept()
            }
        }
    }
}

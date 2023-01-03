//
//  AppDelegate.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import UIKit
import Firebase
import GoogleMobileAds
import AVFAudio
import SwiftyStoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.value(forKey: "Cry") == nil {
            UserDefaults.standard.set("0", forKey: "Cry")
        }
        if UserDefaults.standard.value(forKey: "Froze") == nil {
            UserDefaults.standard.set("0", forKey: "Froze")
        }
        if UserDefaults.standard.value(forKey: "Lonely") == nil {
            UserDefaults.standard.set("0", forKey: "Lonely")
        }
        if UserDefaults.standard.value(forKey: "Happy") == nil {
            UserDefaults.standard.set("0", forKey: "Happy")
        }
        if UserDefaults.standard.value(forKey: "What") == nil {
            UserDefaults.standard.set("0", forKey: "What")
        }
        if UserDefaults.standard.value(forKey: "Bath") == nil {
            UserDefaults.standard.set("0", forKey: "Bath")
        }
        if UserDefaults.standard.value(forKey: "Fear") == nil {
            UserDefaults.standard.set("0", forKey: "Fear")
        }
        if UserDefaults.standard.value(forKey: "Attention") == nil {
            UserDefaults.standard.set("0", forKey: "Attention")
        }
        if UserDefaults.standard.value(forKey: "Hungry") == nil {
            UserDefaults.standard.set("0", forKey: "Hungry")
        }
        if UserDefaults.standard.value(forKey: "Suprised") == nil {
            UserDefaults.standard.set("0", forKey: "Suprised")
        }
        if UserDefaults.standard.value(forKey: "Sleepy") == nil {
            UserDefaults.standard.set("0", forKey: "Sleepy")
        }
        if UserDefaults.standard.value(forKey: "Amazed") == nil {
            UserDefaults.standard.set("0", forKey: "Amazed")
        }
        if UserDefaults.standard.value(forKey: "Love") == nil {
            UserDefaults.standard.set("0", forKey: "Love")
        }
        if UserDefaults.standard.value(forKey: "Yummy") == nil {
            UserDefaults.standard.set("0", forKey: "Yummy")
        }
        
        //Game UD
        if UserDefaults.standard.value(forKey: "score") == nil {
            UserDefaults.standard.set("0", forKey: "score")
        }
        if UserDefaults.standard.value(forKey: "Level") == nil {
            UserDefaults.standard.set(1, forKey: "Level")
        }
        
        
        if UserDefaults.standard.value(forKey: "FullAccess") == nil {
            UserDefaults.standard.set(0, forKey: "FullAccess")
        }
        if UserDefaults.standard.value(forKey: "note") == nil {
            let setValue = 1
            UserDefaults.standard.set(setValue, forKey: "note")
        } else {
            var helper = UserDefaults.standard.value(forKey: "note") as! Int
            helper += 1
            UserDefaults.standard.set(helper, forKey: "note")
        }
        
        
        if UserDefaults.standard.value(forKey: "freeHuman") == nil {
            UserDefaults.standard.set(0, forKey: "freeHuman")
        }
        if UserDefaults.standard.value(forKey: "freeCat") == nil {
            UserDefaults.standard.set(0, forKey: "freeCat")
        }
        //Remote
        
        if UserDefaults.standard.value(forKey: "wController") == nil {
            UserDefaults.standard.set("1", forKey: "wController")
        }
        if UserDefaults.standard.value(forKey: "wSub") == nil {
            UserDefaults.standard.set("{   \"1\": \"com.cattranslator.1wetr\",   \"2\": \"com.cattranslator.1motr\",   \"3\": \"com.cattranslator.1yetr\" }", forKey: "wSub")
        }
        if UserDefaults.standard.value(forKey: "oController") == nil {
            UserDefaults.standard.set("1", forKey: "oController")
        }
        if UserDefaults.standard.value(forKey: "oSub") == nil {
            UserDefaults.standard.set("{   \"1\": \"com.cattranslator.1we\",   \"2\": \"com.cattranslator.1mo\",   \"3\": \"com.cattranslator.1ye\" }", forKey: "oSub")
        }
        if UserDefaults.standard.value(forKey: "availableFreeHuman") == nil {
            UserDefaults.standard.set("20", forKey: "availableFreeHuman")
        }
        if UserDefaults.standard.value(forKey: "availableFreeCat") == nil {
            UserDefaults.standard.set("20", forKey: "availableFreeCat")
        }
        if UserDefaults.standard.value(forKey: "ads") == nil {
            UserDefaults.standard.set("2", forKey: "ads")
        }
        if UserDefaults.standard.value(forKey: "rateUs") == nil {
            UserDefaults.standard.set("1", forKey: "rateUs")
        }
        if UserDefaults.standard.value(forKey: "closeButtonDelay") == nil {
            UserDefaults.standard.set("0", forKey: "closeButtonDelay")
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "1bd9954b9b2486d21efa7dd5309955f2" ]
        FirebaseApp.configure()
        window?.overrideUserInterfaceStyle = .dark
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if IsFirstLaunch.shared.isFirstLaunch {
            window?.rootViewController = TranslatorController()
        } else {
            window?.rootViewController = OnBoard()
        }
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
                for purchase in purchases {
                    switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            // Deliver content from server, then:
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                        // Unlock content
                    case .failed, .purchasing, .deferred:
                        break // do nothing
                    @unknown default:
                        fatalError()
                    }
                }
        }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1mo"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1ye"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1we"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1motr"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1yetr"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        SwiftyStoreKit.retrieveProductsInfo(["com.cattranslator.1wetr"]) {  result in
                    if let product = result.retrievedProducts.first {
                        let priceString = product.localizedPrice!

                    }
                    else if result.invalidProductIDs.first != nil {
                    }
                    else {
                    }
                }
        
        //IAPManager.shared.verifyReceipt()
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("AVAudioSessionCategoryPlayback not work")
        }
    }

}


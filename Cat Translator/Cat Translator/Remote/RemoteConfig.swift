//
//  RemoteConfig.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import FirebaseRemoteConfig

class RemoteConfigFetch {

    static var shared = RemoteConfigFetch()
    let remoteConfig = RemoteConfig.remoteConfig()

    let defaults: [String: NSObject] = [
        "welcomeTourScreenNumber"     : "1" as NSObject,
        "welcomeTourSubscription"     : "{\"1\": \"com.cattranslator.1wetr\",                                                              \"2\": \"com.cattranslator.1motr\",                                                              \"3\": \"com.cattranslator.1yetr\" }" as NSObject,
        "closeButtonDelay"            : "0" as NSObject,
        "adsShow"                     : "2" as NSObject,
        "availableFreeHumanTranslator": "20" as NSObject,
        "availableFreeCatTranslator"  : "20" as NSObject,
        "rateUs"                      : "1" as NSObject,
        "otherScreenNumber"           : "1" as NSObject,
        "otherSubscription"           : "{\"1\": \"com.cattranslator.1we\",                                                                \"2\": \"com.cattranslator.1mo\",                                                                \"3\": \"com.cattranslator.1ye\" }" as NSObject,

    ]

    public func fetchValuesOnBoard() {
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.setDefaults(defaults)
        remoteConfig.configSettings = setting
        remoteConfig.fetchAndActivate { (status, error) in

            if error != nil {

            } else {
                if status != .error{
                    UserDefaults.standard.set(self.remoteConfig["welcomeTourScreenNumber"].stringValue, forKey: "wController")
                    UserDefaults.standard.set(self.remoteConfig["welcomeTourSubscription"].stringValue, forKey: "wSub")
                    UserDefaults.standard.set(self.remoteConfig["closeButtonDelay"].stringValue, forKey: "closeButtonDelay")
                    UserDefaults.standard.set(self.remoteConfig["adsShow"].stringValue, forKey: "ads")
                    UserDefaults.standard.set(self.remoteConfig["availableFreeHumanTranslator"].stringValue, forKey: "availableFreeHuman")
                    UserDefaults.standard.set(self.remoteConfig["availableFreeCatTranslator"].stringValue, forKey: "availableFreeCat")
                    UserDefaults.standard.set(self.remoteConfig["otherScreenNumber"].stringValue, forKey: "oController")
                    UserDefaults.standard.set(self.remoteConfig["otherSubscription"].stringValue, forKey: "oSub")
                    UserDefaults.standard.set(self.remoteConfig["rateUs"].stringValue, forKey: "rateUs")
                    print("Remoute Loaded")
                }
                if status == .error{
                    UserDefaults.standard.set("1", forKey: "wController")
                    UserDefaults.standard.set("{   \"1\": \"com.cattranslator.1wetr\",   \"2\": \"com.cattranslator.1motr\",   \"3\": \"com.cattranslator.1yetr\" }", forKey: "wSub")
                    UserDefaults.standard.set("0", forKey: "closeButtonDelay")
                    UserDefaults.standard.set("2", forKey: "ads")
                    UserDefaults.standard.set("20", forKey: "availableFreeHuman")
                    UserDefaults.standard.set("20", forKey: "availableFreeCat")
                    UserDefaults.standard.set("1", forKey: "oController")
                    UserDefaults.standard.set("{   \"1\": \"com.cattranslator.1we\",   \"2\": \"com.cattranslator.1mo\",   \"3\": \"com.cattranslator.1ye\" }", forKey: "oSub")
                    UserDefaults.standard.set("1", forKey: "rateUs")
                    print("Eror: Remoute UnLoaded")
                }
            }
        }
    }

    public func fetchValues() {

        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.setDefaults(defaults)
        remoteConfig.configSettings = setting
        remoteConfig.fetchAndActivate { (status, error) in

            if error != nil {

            } else {
                if status != .error{
                    UserDefaults.standard.set(self.remoteConfig["adsShow"].stringValue, forKey: "ads")
                    UserDefaults.standard.set(self.remoteConfig["rateUs"].stringValue, forKey: "rateUs")
                    UserDefaults.standard.set(self.remoteConfig["availableFreeHumanTranslator"].stringValue, forKey: "availableFreeHuman")
                    UserDefaults.standard.set(self.remoteConfig["availableFreeCatTranslator"].stringValue, forKey: "availableFreeCat")
                    UserDefaults.standard.set(self.remoteConfig["otherScreenNumber"].stringValue, forKey: "oController")
                    UserDefaults.standard.set(self.remoteConfig["otherSubscription"].stringValue, forKey: "oSub")
                    UserDefaults.standard.set(self.remoteConfig["closeButtonDelay"].stringValue, forKey: "closeButtonDelay")
                    print("Remoute Loaded")
                }
                if status == .error{
                    UserDefaults.standard.set("2", forKey: "ads")
                    UserDefaults.standard.set("1", forKey: "rateUs")
                    UserDefaults.standard.set("20", forKey: "availableFreeHuman")
                    UserDefaults.standard.set("20", forKey: "availableFreeCat")
                    UserDefaults.standard.set("1", forKey: "oController")
                    UserDefaults.standard.set("{   \"1\": \"com.cattranslator.1we\",   \"2\": \"com.cattranslator.1mo\",   \"3\": \"com.cattranslator.1ye\" }", forKey: "oSub")
                    UserDefaults.standard.set("0", forKey: "closeButtonDelay")
                    print("Eror: Remoute UnLoaded")
                }
            }
        }
    }
}

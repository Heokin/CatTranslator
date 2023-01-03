//
//  SecondSubOnBoarding.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 5.12.22.
//

import Foundation
import UIKit
import SwiftyStoreKit

class SecondSubOnBoarding: UICollectionViewCell {
    
    public static var id = "secondSub"
    let swifty = IAPManager()
    
    var buttonDelay = UserDefaults.standard.value(forKey: "closeButtonDelay")
    var first = "com.cattranslator.1wetr"
    var second = "com.cattranslator.1motr"
    var third = "com.cattranslator.1yetr"
    var wPrice = "$0.99"
    var mPrice = "$3.49"
    var yPrice = "$6.99"

    
    var standartHeight = UIScreen.main.bounds.height / 6.1984
    var selecredHeight = UIScreen.main.bounds.height / 5.075
    
    let local = LocalizationVariables()
    
    lazy var mainImage = ImageView(image: .boardingBig)
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        if UIScreen.main.bounds.width > 500 {
            imageView.image = UIImage(named: "backgroundSub")
        } else {
            imageView.image = UIImage(named: "backgroundSub")
        }
            
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var header = Label(type: .subscribeHeader, local.subscribeHeader, "")
    lazy var titleFirst = Label(type: .subscribeTitle, local.subscribeTitleLim, "")
    lazy var titleSecond = Label(type: .subscribeTitle, local.subscribeTitleAds, "")
    
    lazy var firstSubView = View(type: .subscribeSubView)
    var firstTopLabel: Label?
    var firstBottomLabel: Label?
    lazy var firstSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var secondSubView = View(type: .subscribeSubView)
    var secondTopLabel: Label?
    var secondBottomLabel: Label?
    lazy var secondSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var thirdSubView = View(type: .subscribeSubView)
    var thirdTopLabel: Label?
    var thirdBottomLabel: Label?
    lazy var thirdSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var firstSelectedSubView = View(type: .subscribeSubView)
    var firstSelectedTopLabel: Label?
    var firstSelectedBottomLabel: Label?
    lazy var firstSelectedSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var secondSelectedSubView = View(type: .subscribeSubView)
    var secondSelectedTopLabel: Label?
    var secondSelectedBottomLabel: Label?
    lazy var secondSelectedSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var thirdSelectedSubView = View(type: .subscribeSubView)
    var thirdSelectedTopLabel: Label?
    var thirdSelectedBottomLabel: Label?
    lazy var thirdSelectedSubPlace = View(type: .subscribeSubViewPlace)
    
    lazy var restoreView = View(type: .dismissView)
    lazy var restoreLabel = Label(type: .restore, local.buttonRestore, "")
    lazy var dismissView = View(type: .dismissView)
    lazy var xmark = ImageView(image: .xmark)
    
    lazy var restoreTap = UITapGestureRecognizer(target: self, action: #selector(restoreTarget))
    lazy var dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeTarget))
    lazy var recognizeFirst = UITapGestureRecognizer(target: self, action: #selector(firstSub))
    lazy var recognizeSecond = UITapGestureRecognizer(target: self, action: #selector(secondSub))
    lazy var recognizeThird = UITapGestureRecognizer(target: self, action: #selector(thirdSub))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("SubscribeOk"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(restoreAlert(notification:)), name: Notification.Name("RestoreError"), object: nil)
        
        let js = UserDefaults.standard.value(forKey: "wSub") as? String

        if js != nil {
            do{
                if let json = js!.data(using: String.Encoding.utf8){
                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                        self.first = jsonData["1"] as! String
                        self.second = jsonData["2"] as! String
                        self.third = jsonData["3"] as! String
                        print(self.first)
                        print(self.second)
                        print(self.third)
                    }
                }
            }catch {
                print(error.localizedDescription)

            }
        }

        let q = DispatchQueue.global(qos: .default)
        q.async {
            [self] in
            SwiftyStoreKit.retrieveProductsInfo([first]) { [self] result in
                if let product = result.retrievedProducts.first {
                    wPrice = product.localizedPrice!
                    if first == "com.cattranslator.1yetr" {
                        self.firstTopLabel?.attributedText  = noActiveBottom(wPrice, local.subscribeYearly)
                        self.firstSelectedTopLabel?.attributedText = activeBottom(wPrice, local.subscribeYearly)
                    } else if first == "com.cattranslator.1motr" {            self.firstTopLabel?.attributedText = noActiveBottom(wPrice, local.subscribeMonthly)
                        self.firstSelectedTopLabel?.attributedText = activeBottom(wPrice, local.subscribeMonthly)
                    } else if first == "com.cattranslator.1wetr" {
                        self.firstTopLabel?.attributedText = noActiveBottom(wPrice, local.subscribeWeekly)
                        self.firstSelectedTopLabel?.attributedText = activeBottom(wPrice, local.subscribeWeekly)
                    } else {
                        self.firstTopLabel?.text = wPrice
                        self.firstSelectedTopLabel?.text = wPrice
                    }
                }
            }

            SwiftyStoreKit.retrieveProductsInfo([second]) { [self] result in
                if let product = result.retrievedProducts.first {
                    mPrice = product.localizedPrice!
                    if second == "com.cattranslator.1yetr" {
                        UserDefaults.standard.set("com.cattranslator.1yetr", forKey: "sub")
                        self.secondTopLabel?.attributedText = noActiveBottom(mPrice, local.subscribeYearly)
                        self.secondSelectedTopLabel?.attributedText = activeBottom(mPrice, local.subscribeYearly)
                    } else if second == "com.cattranslator.1motr" {
                        UserDefaults.standard.set("com.cattranslator.1motr", forKey: "sub")
                        self.secondTopLabel?.attributedText = noActiveBottom(mPrice, local.subscribeMonthly)
                        self.secondSelectedTopLabel?.attributedText = activeBottom(mPrice, local.subscribeMonthly)
                    } else if second == "com.cattranslator.1wetr" {
                        UserDefaults.standard.set("com.cattranslator.1wetr", forKey: "sub")
                        self.secondTopLabel?.attributedText = noActiveBottom(mPrice, local.subscribeWeekly)
                        self.secondSelectedTopLabel?.attributedText = activeBottom(mPrice, local.subscribeWeekly)
                    } else if second == "com.cattranslator.1we" {
                        UserDefaults.standard.set("com.cattranslator.1we", forKey: "sub")
                        self.secondTopLabel?.text = mPrice
                        self.secondSelectedTopLabel?.text = mPrice
                    } else if second == "com.cattranslator.1mo" {
                        UserDefaults.standard.set("com.cattranslator.1mo", forKey: "sub")
                        self.secondTopLabel?.text = mPrice
                        self.secondSelectedTopLabel?.text = mPrice
                    } else if second == "com.cattranslator.1ye" {
                        UserDefaults.standard.set("com.cattranslator.1ye", forKey: "sub")
                        self.secondTopLabel?.text = mPrice
                        self.secondSelectedTopLabel?.text = mPrice
                    }
                }
            }

            SwiftyStoreKit.retrieveProductsInfo([third]) { [self] result in
                if let product = result.retrievedProducts.first {
                    yPrice = product.localizedPrice!
                    if third == "com.cattranslator.1yetr" {
                        self.thirdTopLabel?.attributedText = noActiveBottom(yPrice, local.subscribeYearly)
                        self.thirdSelectedTopLabel?.attributedText = activeBottom(yPrice, local.subscribeYearly)
                    } else if third == "com.cattranslator.1motr" {
                        self.thirdTopLabel?.attributedText = noActiveBottom(yPrice, local.subscribeMonthly)
                        self.thirdSelectedTopLabel?.attributedText = activeBottom(yPrice, local.subscribeMonthly)
                    } else if third == "com.cattranslator.1wetr" {
                        self.thirdTopLabel?.attributedText = noActiveBottom(yPrice, local.subscribeWeekly)
                        self.thirdSelectedTopLabel?.attributedText = activeBottom(yPrice, local.subscribeWeekly)
                    } else {
                        self.thirdTopLabel?.text = yPrice
                        self.thirdSelectedTopLabel?.text = yPrice
                    }
                    print(yPrice)
                }
            }
        }
        
        if self.first == "com.cattranslator.1wetr"{
            self.firstTopLabel = Label(type: .subscribeTopPrice, wPrice + "\n", local.subscribeWeekly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.firstBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeWeekly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.first == "com.cattranslator.1yetr"{
            self.firstTopLabel = Label(type: .subscribeTopPrice, yPrice + "\n", local.subscribeYearly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopPriceActive, yPrice + "\n", local.subscribeYearly)
            self.firstBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeYearly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.first == "com.cattranslator.1motr" {
            self.firstTopLabel = Label(type: .subscribeTopPrice, mPrice + "\n",  local.subscribeMonthly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopPriceActive, mPrice + "\n",  local.subscribeMonthly)
            self.firstBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial,  local.subscribeMonthly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial,  local.subscribeMonthly)
        } else if self.first == "com.cattranslator.1we"{
            self.firstTopLabel = Label(type: .priceTop, wPrice, local.subscribeWeekly)
            self.firstSelectedTopLabel = Label(type: .priceTopActive, wPrice, local.subscribeWeekly)
            self.firstBottomLabel = Label(type: .dayBot, local.subscribeWeekly, local.subscribeWeekly)
            self.firstSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.first == "com.cattranslator.1ye"{
            self.firstTopLabel = Label(type: .priceTop, yPrice, local.subscribeYearly)
            self.firstSelectedTopLabel = Label(type: .priceTopActive, yPrice, local.subscribeYearly)
            self.firstBottomLabel = Label(type: .dayBot, local.subscribeYearly, local.subscribeYearly)
            self.firstSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.first == "com.cattranslator.1mo" {
            self.firstTopLabel = Label(type: .priceTop, mPrice,  local.subscribeMonthly)
            self.firstSelectedTopLabel = Label(type: .priceTopActive, mPrice,  local.subscribeMonthly)
            self.firstBottomLabel = Label(type: .dayBot, local.subscribeMonthly,  local.subscribeMonthly)
            self.firstSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeMonthly,  local.subscribeMonthly)
        }
        
        if self.second == "com.cattranslator.1wetr"{
            self.secondTopLabel = Label(type: .subscribeTopPrice, wPrice + "\n", local.subscribeWeekly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.secondBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeWeekly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.second == "com.cattranslator.1yetr"{
            self.secondTopLabel = Label(type: .subscribeTopPrice, yPrice + "\n", local.subscribeYearly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopPriceActive, yPrice + "\n", local.subscribeYearly)
            self.secondBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeYearly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.second == "com.cattranslator.1motr" {
            self.secondTopLabel = Label(type: .subscribeTopPrice, mPrice + "\n",  local.subscribeMonthly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopPriceActive, mPrice + "\n",  local.subscribeMonthly)
            self.secondBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial,  local.subscribeMonthly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial,  local.subscribeMonthly)
        } else if self.second == "com.cattranslator.1we"{
            self.secondTopLabel = Label(type: .priceTop, wPrice, local.subscribeWeekly)
            self.secondSelectedTopLabel = Label(type: .priceTopActive, wPrice, local.subscribeWeekly)
            self.secondBottomLabel = Label(type: .dayBot, local.subscribeWeekly, local.subscribeWeekly)
            self.secondSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.second == "com.cattranslator.1ye"{
            self.secondTopLabel = Label(type: .priceTop, yPrice, local.subscribeYearly)
            self.secondSelectedTopLabel = Label(type: .priceTopActive, yPrice, local.subscribeYearly)
            self.secondBottomLabel = Label(type: .dayBot, local.subscribeYearly, local.subscribeYearly)
            self.secondSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.second == "com.cattranslator.1mo" {
            self.secondTopLabel = Label(type: .priceTop, mPrice,  local.subscribeMonthly)
            self.secondSelectedTopLabel = Label(type: .priceTopActive, mPrice,  local.subscribeMonthly)
            self.secondBottomLabel = Label(type: .dayBot, local.subscribeMonthly,  local.subscribeMonthly)
            self.secondSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeMonthly,  local.subscribeMonthly)
        }
        
        if self.third == "com.cattranslator.1wetr"{
            self.thirdTopLabel = Label(type: .subscribeTopPrice, wPrice + "\n", local.subscribeWeekly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.thirdBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeWeekly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.third == "com.cattranslator.1yetr"{
            self.thirdTopLabel = Label(type: .subscribeTopPrice, yPrice + "\n", local.subscribeYearly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopPriceActive, yPrice + "\n", local.subscribeYearly)
            self.thirdBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial, local.subscribeYearly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.third == "com.cattranslator.1motr" {
            self.thirdTopLabel = Label(type: .subscribeTopPrice, mPrice + "\n",  local.subscribeMonthly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopPriceActive, mPrice + "\n",  local.subscribeMonthly)
            self.thirdBottomLabel = Label(type: .subscribeBottom, local.subscribeFreeTrial,  local.subscribeMonthly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomActive, local.subscribeFreeTrial,  local.subscribeMonthly)
        } else if self.third == "com.cattranslator.1we"{
            self.thirdTopLabel = Label(type: .priceTop, wPrice, local.subscribeWeekly)
            self.thirdSelectedTopLabel = Label(type: .priceTopActive, wPrice, local.subscribeWeekly)
            self.thirdBottomLabel = Label(type: .dayBot, local.subscribeWeekly, local.subscribeWeekly)
            self.thirdSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.third == "com.cattranslator.1ye"{
            self.thirdTopLabel = Label(type: .priceTop, yPrice, local.subscribeYearly)
            self.thirdSelectedTopLabel = Label(type: .priceTopActive, yPrice, local.subscribeYearly)
            self.thirdBottomLabel = Label(type: .dayBot, local.subscribeYearly, local.subscribeYearly)
            self.thirdSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.third == "com.cattranslator.1mo" {
            self.thirdTopLabel = Label(type: .priceTop, mPrice,  local.subscribeMonthly)
            self.thirdSelectedTopLabel = Label(type: .priceTopActive, mPrice,  local.subscribeMonthly)
            self.thirdBottomLabel = Label(type: .dayBot, local.subscribeMonthly,  local.subscribeMonthly)
            self.thirdSelectedBottomLabel = Label(type: .dayBotActive, local.subscribeMonthly,  local.subscribeMonthly)
        }
        
        self.setup()
        self.setupLogic()
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

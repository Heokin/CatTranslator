//
//  FirstSubscribeController.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 7.12.22.
//

import Foundation
import UIKit
import SwiftyStoreKit

class FirstSubscribeViewController: UIViewController{

    var buttonDelay = UserDefaults.standard.value(forKey: "closeButtonDelay") as? String
    
    var subs = ""
    var swifty = IAPManager()
    
    var first = "com.cattranslator.1wetr"
    var second = "com.cattranslator.1motr"
    var third = "com.cattranslator.1yetr"
    var wPrice = "$0.99"
    var mPrice = "$3.49"
    var yPrice = "$6.99"
    var spiner = UIActivityIndicatorView(style: .large)
    
    var standartHeight = UIScreen.main.bounds.height / 6.1984
    var selecredHeight = UIScreen.main.bounds.height / 5.075
    
    let local = LocalizationVariables()
    
    lazy var mainImage = ImageView(image: .boardingBig)
    
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
    
    lazy var continueButton = Button(type: .subscribeContinue, local.continueOnBoarding)
    
    lazy var restoreView = View(type: .dismissView)
    lazy var restoreLabel = Label(type: .restore, local.buttonRestore, "")
    lazy var dismissView = View(type: .dismissView)
    lazy var xmark = ImageView(image: .xmark)
    
    lazy var restoreTap = UITapGestureRecognizer(target: self, action: #selector(restoreTarget))
    lazy var dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeTarget))
    lazy var recognizeFirst = UITapGestureRecognizer(target: self, action: #selector(firstSub))
    lazy var recognizeSecond = UITapGestureRecognizer(target: self, action: #selector(secondSub))
    lazy var recognizeThird = UITapGestureRecognizer(target: self, action: #selector(thirdSub))
    
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
    
    
    override func viewDidLoad() {

        //self.sendSubviewToBack(imageView)
        
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
                        self.firstBottomLabel?.attributedText = noActiveBottom(wPrice, local.subscribeYearly)
                        self.firstSelectedBottomLabel?.attributedText = activeBottom(wPrice, local.subscribeYearly)
                    } else if first == "com.cattranslator.1motr" {
                        self.firstBottomLabel?.attributedText = noActiveBottom(wPrice, local.subscribeMonthly)
                        self.firstSelectedBottomLabel?.attributedText = activeBottom(wPrice, local.subscribeMonthly)
                    } else if first == "com.cattranslator.1wetr" {
                        self.firstBottomLabel?.attributedText = noActiveBottom(wPrice, local.subscribeWeekly)
                        self.firstSelectedBottomLabel?.attributedText = activeBottom(wPrice, local.subscribeWeekly)
                    } else {
                        self.firstBottomLabel?.text = wPrice
                        self.firstSelectedBottomLabel?.text = wPrice
                    }
                }
            }

            SwiftyStoreKit.retrieveProductsInfo([second]) { [self] result in
                if let product = result.retrievedProducts.first {
                    mPrice = product.localizedPrice!
                    if second == "com.cattranslator.1yetr" {
                        subs = "com.cattranslator.1yetr"
                        self.secondBottomLabel?.attributedText = noActiveBottom(mPrice, local.subscribeYearly)
                        self.secondSelectedBottomLabel?.attributedText = activeBottom(mPrice, local.subscribeYearly)
                    } else if second == "com.cattranslator.1motr" {
                        subs = "com.cattranslator.1motr"
                        self.secondBottomLabel?.attributedText = noActiveBottom(mPrice, local.subscribeMonthly)
                        self.secondSelectedBottomLabel?.attributedText = activeBottom(mPrice, local.subscribeMonthly)
                    } else if second == "com.cattranslator.1wetr" {
                        subs = "com.cattranslator.1wetr"
                        self.secondBottomLabel?.attributedText = noActiveBottom(mPrice, local.subscribeWeekly)
                        self.secondSelectedBottomLabel?.attributedText = activeBottom(mPrice, local.subscribeWeekly)
                    } else if second == "com.cattranslator.1we" {
                        subs = "com.cattranslator.1we"
                        self.secondBottomLabel?.text = mPrice
                        self.secondSelectedBottomLabel?.text = mPrice
                    } else if second == "com.cattranslator.1mo" {
                        subs = "com.cattranslator.1mo"
                        self.secondBottomLabel?.text = mPrice
                        self.secondSelectedBottomLabel?.text = mPrice
                    } else if second == "com.cattranslator.1ye" {
                        subs = "com.cattranslator.1ye"
                        self.secondBottomLabel?.text = mPrice
                        self.secondSelectedBottomLabel?.text = mPrice
                    }
                }
            }

            SwiftyStoreKit.retrieveProductsInfo([third]) { [self] result in
                if let product = result.retrievedProducts.first {
                    yPrice = product.localizedPrice!
                    if third == "com.cattranslator.1yetr" {
                        self.thirdBottomLabel?.attributedText = noActiveBottom(yPrice, local.subscribeYearly)
                        self.thirdSelectedBottomLabel?.attributedText = activeBottom(yPrice, local.subscribeYearly)
                    } else if third == "com.cattranslator.1motr" {
                        self.thirdBottomLabel?.attributedText = noActiveBottom(yPrice, local.subscribeMonthly)
                        self.thirdSelectedBottomLabel?.attributedText = activeBottom(yPrice, local.subscribeMonthly)
                    } else if third == "com.cattranslator.1wetr" {
                        self.thirdBottomLabel?.attributedText = noActiveBottom(yPrice, local.subscribeWeekly)
                        self.thirdSelectedBottomLabel?.attributedText = activeBottom(yPrice, local.subscribeWeekly)
                    } else {
                        self.thirdBottomLabel?.text = yPrice
                        self.thirdSelectedBottomLabel?.text = yPrice
                    }
                }
            }
        }
        
        if self.first == "com.cattranslator.1wetr"{
            self.firstBottomLabel = Label(type: .subscribeBottomPrice, wPrice + "\n", local.subscribeWeekly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.firstTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeWeekly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.first == "com.cattranslator.1yetr"{
            self.firstBottomLabel = Label(type: .subscribeBottomPrice, yPrice + "\n", local.subscribeYearly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, yPrice + "\n", local.subscribeYearly)
            self.firstTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeYearly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.first == "com.cattranslator.1motr"{
            self.firstBottomLabel = Label(type: .subscribeBottomPrice, mPrice + "\n", local.subscribeMonthly)
            self.firstSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, mPrice + "\n", local.subscribeMonthly)
            self.firstTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeMonthly)
            self.firstSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeMonthly)
        } else if self.first == "com.cattranslator.1we"{
            self.firstBottomLabel = Label(type: .priceBot, wPrice, local.subscribeWeekly)
            self.firstSelectedBottomLabel = Label(type: .priceBotActive, wPrice, local.subscribeWeekly)
            self.firstTopLabel = Label(type: .dayTop, local.subscribeWeekly, local.subscribeWeekly)
            self.firstSelectedTopLabel = Label(type: .dayTopActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.first == "com.cattranslator.1ye"{
            self.firstBottomLabel = Label(type: .priceBot, yPrice, local.subscribeYearly)
            self.firstSelectedBottomLabel = Label(type: .priceBotActive, yPrice, local.subscribeYearly)
            self.firstTopLabel = Label(type: .dayTop, local.subscribeYearly, local.subscribeYearly)
            self.firstSelectedTopLabel = Label(type: .dayTopActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.first == "com.cattranslator.1mo"{
            self.firstBottomLabel = Label(type: .priceBot, mPrice, local.subscribeMonthly)
            self.firstSelectedBottomLabel = Label(type: .priceBotActive, mPrice, local.subscribeMonthly)
            self.firstTopLabel = Label(type: .dayTop, local.subscribeMonthly, local.subscribeMonthly)
            self.firstSelectedTopLabel = Label(type: .dayTopActive, local.subscribeMonthly, local.subscribeMonthly)
        }
        
        
        if self.second == "com.cattranslator.1wetr"{
            self.secondBottomLabel = Label(type: .subscribeBottomPrice, wPrice + "\n", local.subscribeWeekly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.secondTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeWeekly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.second == "com.cattranslator.1yetr"{
            self.secondBottomLabel = Label(type: .subscribeBottomPrice, yPrice + "\n", local.subscribeYearly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, yPrice + "\n", local.subscribeYearly)
            self.secondTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeYearly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.second == "com.cattranslator.1motr"{
            self.secondBottomLabel = Label(type: .subscribeBottomPrice, mPrice + "\n", local.subscribeMonthly)
            self.secondSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, mPrice + "\n", local.subscribeMonthly)
            self.secondTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeMonthly)
            self.secondSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeMonthly)
        } else if self.second == "com.cattranslator.1we"{
            self.secondBottomLabel = Label(type: .priceBot, wPrice, local.subscribeWeekly)
            self.secondSelectedBottomLabel = Label(type: .priceBotActive, wPrice, local.subscribeWeekly)
            self.secondTopLabel = Label(type: .dayTop, local.subscribeWeekly, local.subscribeWeekly)
            self.secondSelectedTopLabel = Label(type: .dayTopActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.second == "com.cattranslator.1ye"{
            self.secondBottomLabel = Label(type: .priceBot, yPrice, local.subscribeYearly)
            self.secondSelectedBottomLabel = Label(type: .priceBotActive, yPrice, local.subscribeYearly)
            self.secondTopLabel = Label(type: .dayTop, local.subscribeYearly, local.subscribeYearly)
            self.secondSelectedTopLabel = Label(type: .dayTopActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.second == "com.cattranslator.1mo"{
            self.secondBottomLabel = Label(type: .priceBot, mPrice, local.subscribeMonthly)
            self.secondSelectedBottomLabel = Label(type: .priceBotActive, mPrice, local.subscribeMonthly)
            self.secondTopLabel = Label(type: .dayTop, local.subscribeMonthly, local.subscribeMonthly)
            self.secondSelectedTopLabel = Label(type: .dayTopActive, local.subscribeMonthly, local.subscribeMonthly)
        }
        
        
        if self.third == "com.cattranslator.1wetr"{
            self.thirdBottomLabel = Label(type: .subscribeBottomPrice, wPrice + "\n", local.subscribeWeekly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, wPrice + "\n", local.subscribeWeekly)
            self.thirdTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeWeekly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeWeekly)
        } else if self.third == "com.cattranslator.1yetr"{
            self.thirdBottomLabel = Label(type: .subscribeBottomPrice, yPrice + "\n", local.subscribeYearly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, yPrice + "\n", local.subscribeYearly)
            self.thirdTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeYearly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeYearly)
        } else if self.third == "com.cattranslator.1motr"{
            self.thirdBottomLabel = Label(type: .subscribeBottomPrice, mPrice + "\n", local.subscribeMonthly)
            self.thirdSelectedBottomLabel = Label(type: .subscribeBottomPriceActive, mPrice + "\n", local.subscribeMonthly)
            self.thirdTopLabel = Label(type: .subscribeTop, local.subscribeFreeTrial, local.subscribeMonthly)
            self.thirdSelectedTopLabel = Label(type: .subscribeTopActive, local.subscribeFreeTrial, local.subscribeMonthly)
        } else if self.third == "com.cattranslator.1we"{
            self.thirdBottomLabel = Label(type: .priceBot, wPrice, local.subscribeWeekly)
            self.thirdSelectedBottomLabel = Label(type: .priceBotActive, wPrice, local.subscribeWeekly)
            self.thirdTopLabel = Label(type: .dayTop, local.subscribeWeekly, local.subscribeWeekly)
            self.thirdSelectedTopLabel = Label(type: .dayTopActive, local.subscribeWeekly, local.subscribeWeekly)
        } else if self.third == "com.cattranslator.1ye"{
            self.thirdBottomLabel = Label(type: .priceBot, yPrice, local.subscribeYearly)
            self.thirdSelectedBottomLabel = Label(type: .priceBotActive, yPrice, local.subscribeYearly)
            self.thirdTopLabel = Label(type: .dayTop, local.subscribeYearly, local.subscribeYearly)
            self.thirdSelectedTopLabel = Label(type: .dayTopActive, local.subscribeYearly, local.subscribeYearly)
        } else if self.third == "com.cattranslator.1mo"{
            self.thirdBottomLabel = Label(type: .priceBot, mPrice, local.subscribeMonthly)
            self.thirdSelectedBottomLabel = Label(type: .priceBotActive, mPrice, local.subscribeMonthly)
            self.thirdTopLabel = Label(type: .dayTop, local.subscribeMonthly, local.subscribeMonthly)
            self.thirdSelectedTopLabel = Label(type: .dayTopActive, local.subscribeMonthly, local.subscribeMonthly)
        }
        
        self.setup()
        
        if buttonDelay == nil {
            buttonDelay = "0"
        }
        
        let _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(buttonDelay as! String)!, repeats: false) { [self] Timer in
            dismissView.isHidden = false
            xmark.isHidden = false
        }
        
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

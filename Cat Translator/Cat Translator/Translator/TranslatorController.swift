//
//  TranslatorController.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import GoogleMobileAds
import AVFoundation
import StoreKit
import MessageUI
import StoreKit

class TranslatorController : UIViewController {
    
    //MARK: Support var
    
    var ads = UserDefaults.standard.value(forKey: "ads")
    var oController = UserDefaults.standard.value(forKey: "oController")
    let local = LocalizationVariables()
    
    var isHuman = true
    let halfX = UIScreen.main.bounds.width/2
    let halfY = UIScreen.main.bounds.height/2
    
    var maxDecibel = 1
    var timeDecibel = 0.0
    var tapActivate = false
    var firstTap = false
    
    var f = true
    
    var path: UIBezierPath?
    
    let trackShape = CAShapeLayer()
    //let trackHalfHelp = CAShapeLayer()
    let subShape = CAShapeLayer()
    //let subShapeHelp = CAShapeLayer()
    let firstSquare = CAShapeLayer()
    let secondSquare = CAShapeLayer()
    let thirdSquare = CAShapeLayer()
    
    let firstHalf = CAShapeLayer()
    //let firstHalfHelp = CAShapeLayer()
    let secondHalf = CAShapeLayer()
    //let secondHalfHelp = CAShapeLayer()
    let rect = CAShapeLayer()
    //let rectHelp = CAShapeLayer()
    
    let firstCircle = CAShapeLayer()
    //let firstCircleHelp = CAShapeLayer()
    
    let ringMicro = CAShapeLayer()
    
    let freeform = UIBezierPath()
    let subform = UIBezierPath()
    let ringMicroPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - 30),
                                        radius: 30 ,
                                        startAngle: -(.pi / 2) ,
                                        endAngle: .pi * 2,
                                        clockwise: true)
    
    let firstHalfPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 - 10),
                                    radius: 60,
                                     startAngle: .pi+1.5,
                                     endAngle: 0.73,
                            clockwise: false)
    
    let secondHalfPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 + 45 , y: UIScreen.main.bounds.height/2 - 10),
                                    radius: 60,
                                      startAngle: .pi - 0.73,
                                      endAngle: .pi + 1.5,
                            clockwise: false)
    
    let thirdHalfPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 - 3, y: UIScreen.main.bounds.height/2 - 60),
                                    radius: 45,
                                     startAngle: -0.22,
                                     endAngle: .pi + 0.22,
                            clockwise: false)
    
    let firstCirclePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 - 110 , y: UIScreen.main.bounds.height/2 - 90),
                                    radius: 30,
                                     startAngle: -(.pi / 2) ,
                                     endAngle: .pi * 2,
                            clockwise: true)
    
    let secondCirclePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2  - 50, y: UIScreen.main.bounds.height/2 - 150),
                                    radius: 30,
                                     startAngle: -(.pi / 2) ,
                                     endAngle: .pi * 2,
                            clockwise: true)
    
    let thirdCirclePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 - 150),
                                    radius: 30,
                                     startAngle: -(.pi / 2) ,
                                     endAngle: .pi * 2,
                            clockwise: true)
    
    let fourthCirclePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2 + 110, y: UIScreen.main.bounds.height/2 - 90),
                                    radius: 30,
                                     startAngle: -(.pi / 2) ,
                                     endAngle: .pi * 2,
                            clockwise: true)
    

    
    let rectPath = UIBezierPath(rect: CGRect(x: UIScreen.main.bounds.width/2 - 48, y: UIScreen.main.bounds.height/2 - 70, width: 99, height: 99))
    
    let firstPath = UIBezierPath()
    let secondPath = UIBezierPath()
    let thirdPath = UIBezierPath()
    let fourthPath = UIBezierPath()
    
    let firstCircleHelpPath = UIBezierPath()
    let secondCircleHelpPath = UIBezierPath()
    
    //MARK: Create UI elements
    
    lazy var micro = ImageView(image: .micro)
    
    lazy var navigationView = View(type: .navigationView)
    lazy var navigationHeader = Label(type: .pageTitle, local.titleTranslator, "")
    lazy var navigationSetting = Button(type: .navigationSetting, nil)
    lazy var navigationSubscribe = Button(type: .navigationSubscribe, nil)
    lazy var roundedSettingView = View(type: .roundedView)
    lazy var roundedSubscribeView = View(type: .roundedView)
    
    lazy var helpTextLabel = Label(type: .regular17, "", "")
    
    lazy var emotionButton = Button(type: .emotions, "akfkefe")
    lazy var gameButton = Button(type: .game, "game")
    
    var recorder = Recorder()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        if UIScreen.main.bounds.width > 500 {
            imageView.image = UIImage(named: "backgroundMainIPad")
        } else if UIScreen.main.bounds.height > 668 {
            imageView.image = UIImage(named: "backgroundMainLow")
        } else {
            imageView.image = UIImage(named: "backgroundMain")
        }
            
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var baner: GADBannerView?
    lazy var vads = View(type: .ads)
    
    lazy var segment = SegmentControl(items: [
        UIImage(named: "humanIconActive")?.withRenderingMode(.alwaysOriginal),
        UIImage(named: "catIcon")?.withRenderingMode(.alwaysOriginal)])
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadLayout), name: Notification.Name("SubscribeOk"), object: nil)
        
        super.viewDidLoad()
        
        recorder.delegate = self
        recorder.avDelegate = self

        
        firstHalfPath.append(secondHalfPath)
        firstHalfPath.append(thirdHalfPath)

        firstPath.move(to: CGPoint(x: UIScreen.main.bounds.width/2 - 125 , y: UIScreen.main.bounds.height/2 - 120))
        firstPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2 - 130 , y: UIScreen.main.bounds.height/2 - 128))
        firstCirclePath.append(firstPath)
        firstCirclePath.append(secondCirclePath)
        secondPath.move(to: CGPoint(x: UIScreen.main.bounds.width/2  - 60, y: UIScreen.main.bounds.height/2 - 180))
        secondPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2 - 62 , y: UIScreen.main.bounds.height/2 - 188))
        firstCirclePath.append(secondPath)
        firstCirclePath.append(thirdCirclePath)
        thirdPath.move(to: CGPoint(x: UIScreen.main.bounds.width/2 + 60, y: UIScreen.main.bounds.height/2 - 180))
        thirdPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2 + 62, y: UIScreen.main.bounds.height/2 - 188))
        firstCirclePath.append(thirdPath)
        firstCirclePath.append(fourthCirclePath)
        fourthPath.move(to: CGPoint(x: UIScreen.main.bounds.width/2 + 125, y: UIScreen.main.bounds.height/2 - 120))
        fourthPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2 + 130 , y: UIScreen.main.bounds.height/2 - 128))
        firstCirclePath.append(fourthPath)
        
        
        if UserDefaults.standard.value(forKey: "note") as! Int == 2 && UserDefaults.standard.value(forKey: "rateUs") as! String == "0" {
            print("STAR REWIEW")
            SKStoreReviewController.requestReview()
            var helper = UserDefaults.standard.value(forKey: "note") as! Int
            helper += 1
            UserDefaults.standard.set(helper, forKey: "note")
        } else if UserDefaults.standard.value(forKey: "note") as! Int == 2 && UserDefaults.standard.value(forKey: "rateUs") as! String == "1" {
            DispatchQueue.main.async {
                self.rate()
            }
            var helper = UserDefaults.standard.value(forKey: "note") as! Int
            helper += 1
            UserDefaults.standard.set(helper, forKey: "note")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IsFirstLaunch.shared.isFirstLaunch = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        RemoteConfigFetch.shared.fetchValues()
        oController = UserDefaults.standard.value(forKey: "oController")

        
        if UserDefaults.standard.value(forKey: "ads") as? String != nil {
            ads = UserDefaults.standard.value(forKey: "ads") as? String ?? "2"
        } else {
            ads = "2"
        }
        if UserDefaults.standard.value(forKey: "FullAccess") as! Int == 1 {
            ads = "0"
            baner = nil
        }
        if ads as? String == "0" {
            vads.isHidden = true
            setup()
            navigationView.snp.remakeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
                    make.left.right.equalTo(view).inset(16)
                    make.height.equalTo(52)
            }
        } else if ads as? String == "1"{
            vads.isHidden = false
            
            baner = GADBannerView(adSize: GADAdSizeBanner)
            baner?.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.layer.backgroundColor = UIColor.clear.cgColor
            vads.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            if UIScreen.main.bounds.height < 700 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-100, width: view.frame.size.width, height: 50).integral

                    } else {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-150, width: view.frame.size.width, height: 50).integral
                    }
                    
                    if UIScreen.main.bounds.height > 950 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-120, width: view.frame.size.width, height: 50).integral
                    }
            baner?.rootViewController = self
            baner?.load(GADRequest())
            setup()
        } else {
            vads.isHidden = false
            baner = GADBannerView(adSize: GADAdSizeBanner)
            baner?.adUnitID = "ca-app-pub-4602239242191301/9691776350"
            baner?.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.layer.backgroundColor = UIColor.clear.cgColor
            vads.backgroundColor = UIColor.clear.withAlphaComponent(0)
            if UIScreen.main.bounds.height < 700 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-100, width: view.frame.size.width, height: 50).integral

                    } else {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-150, width: view.frame.size.width, height: 50).integral
                    }
                    
                    if UIScreen.main.bounds.height > 950 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-120, width: view.frame.size.width, height: 50).integral
                    }
            baner?.rootViewController = self
            baner?.load(GADRequest())
            setup()
        }
        
        if UserDefaults.standard.value(forKey: "FullAccess") as? Int == 1 {
            roundedSubscribeView.isHidden = true
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in }
        
    }
    
    @objc func reloadLayout() {
        if UserDefaults.standard.value(forKey: "ads") as? String != nil {
            ads = UserDefaults.standard.value(forKey: "ads") as? String ?? "2"
        } else {
            ads = "2"
        }
        if UserDefaults.standard.value(forKey: "FullAccess") as! Int == 1 {
            ads = "0"
            baner = nil
        }
        if ads as? String == "0" {
            vads.isHidden = true
            setup()
            navigationView.snp.remakeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
                    make.left.right.equalTo(view).inset(16)
                    make.height.equalTo(52)
            }
        } else if ads as? String == "1"{
            vads.isHidden = false
            
            baner = GADBannerView(adSize: GADAdSizeBanner)
            baner?.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.layer.backgroundColor = UIColor.clear.cgColor
            vads.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            if UIScreen.main.bounds.height < 700 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-100, width: view.frame.size.width, height: 50).integral

                    } else {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-150, width: view.frame.size.width, height: 50).integral
                    }
                    
                    if UIScreen.main.bounds.height > 950 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-120, width: view.frame.size.width, height: 50).integral
                    }
            baner?.rootViewController = self
            baner?.load(GADRequest())
            setup()
        } else {
            vads.isHidden = false
            baner = GADBannerView(adSize: GADAdSizeBanner)
            baner?.adUnitID = "ca-app-pub-4602239242191301/9691776350"
            baner?.backgroundColor = UIColor.clear.withAlphaComponent(0)
            baner?.layer.backgroundColor = UIColor.clear.cgColor
            vads.backgroundColor = UIColor.clear.withAlphaComponent(0)
            if UIScreen.main.bounds.height < 700 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-100, width: view.frame.size.width, height: 50).integral

                    } else {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-150, width: view.frame.size.width, height: 50).integral
                    }
                    
                    if UIScreen.main.bounds.height > 950 {
                        baner?.frame = CGRect(x: 0, y: view.frame.size.height-120, width: view.frame.size.width, height: 50).integral
                    }
            baner?.rootViewController = self
            baner?.load(GADRequest())
            setup()
        }
        
        if UserDefaults.standard.value(forKey: "FullAccess") as? Int == 1 {
            roundedSubscribeView.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
}

extension TranslatorController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

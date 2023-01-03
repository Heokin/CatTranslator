//
//  PopUp.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 12.12.22.
//

//import Foundation
//import UIKit
//import SnapKit
//import GoogleMobileAds
//
//class PopUpBoard: UIViewController, GADFullScreenContentDelegate {
//    
//    let local = LocalizationVariables()
//    
//    var rewardedAd: GADRewardedAd?
//    
//    lazy var activityViewController: UIActivityViewController? = nil
//    
//    public var backgroundColor: UIColor?
//    public var image: UIImage?
//    
//    public var textFree = ""
//    
//    lazy var viewBoard = UIView()
//    //lazy var vw = Button(type: .free, "")
//    lazy var unlockView = View(type: .subscribeView)
//    lazy var unlockImage = ImageView(image: .nothing)
//    lazy var unlockLabel = Label(type: .subLabel, local.freeButton, "")
//    lazy var unlockTap = UITapGestureRecognizer(target: self, action: #selector(free))
//    //lazy var bg = Button(type: .free, "")
//    lazy var board = UIView()
//    lazy var cat = ImageView(image: .nothing)
//    lazy var imageMain = ImageView(image: .popUpImage)
//    
//    lazy var dismissView = View(type: .roundedView)
//    lazy var xmark = Button(type: .xmark, nil)
//    
//    //lazy var buttonClose = Button(type: .end, "")
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        //vw.addTarget(self, action: #selector(free), for: .touchUpInside)
//        print(textFree)
//    }
//    
//    func setup() {
//        view.backgroundColor = UIColor(named: "oppacity")
//        
//        viewBoard.translatesAutoresizingMaskIntoConstraints = false
//        board.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(viewBoard)
//        imageMain.addSubview(board)
//        view.addSubview(unlockView)
//        unlockView.addSubview(unlockImage)
//        unlockView.addSubview(unlockLabel)
//        imageMain.addSubview(cat)
//        
//        
//        view.addSubview(dismissView)
//        dismissView.addSubview(xmark)
//        
//        cat.image = image
//        
//        board.backgroundColor = backgroundColor
//        board.layer.borderWidth = 2
//        board.layer.borderColor = UIColor.black.cgColor
//        board.layer.cornerRadius = 8
//        
//        unlockView.backgroundColor = UIColor(named: "purple")
//        dismissView.backgroundColor = UIColor(named: "lightYellow")
//        
//        unlockView.layer.cornerRadius = 14
//        unlockImage.image = UIImage(named: "gift")
//        
//        unlockLabel.font = UIFont.rounded(ofSize: 20, weight: .medium)
//        
//        viewBoard.addSubview(imageMain)
//        
//        viewBoard.addSubview(dismissView)
//
//        xmark.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
//        unlockView.addGestureRecognizer(unlockTap)
//        
//        
//        
//        viewBoard.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(400)
//        }
//        
//        imageMain.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//        
//        dismissView.snp.makeConstraints { make in
//            make.top.equalTo(viewBoard.snp.top).offset(-20)
//            make.right.equalTo(viewBoard.snp.right).offset(-20)
//        }
//        
//        xmark.snp.makeConstraints { make in
//            make.center.equalTo(dismissView)
//        }
//        
//        unlockView.snp.makeConstraints { make in
//            make.bottom.equalTo(imageMain.snp.bottom).inset(34)
//            make.right.equalTo(imageMain.snp.right).offset(-22)
//            make.width.equalTo(184)
//            make.height.equalTo(58)
//        }
//        
//        unlockLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-40)
//        }
//
//        unlockImage.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(24)
//        }
//        
//        board.snp.makeConstraints { make in
//            make.bottom.equalTo(unlockView.snp.top).offset(-16)
//            make.centerX.equalTo(unlockView.snp.centerX)
//            make.width.height.equalTo(86)
//        }
//        
//        cat.snp.makeConstraints { make in
//            make.centerY.equalTo(board.snp.centerY)
//            make.centerX.equalTo(unlockView.snp.centerX)
//            make.width.height.equalTo(65)
//        }      
//    }
//    
//    
//    @objc func handleClose(paramSander: Any){
//        dismiss(animated: false, completion: nil)
//    }
//    
//    @objc func free(){
//        loadRewardedAd()
//        //show()
//        if UserDefaults.standard.value(forKey: textFree) != nil {
//            UserDefaults.standard.set("1", forKey: textFree)
//        }
//        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
//        dismiss(animated: false, completion: nil)
//    }
//    
//    func loadRewardedAd() {
//        
//        if UserDefaults.standard.value(forKey: "ads") as? String == "2" {
//            let request = GADRequest()
//            //ca-app-pub-3940256099942544/1712485313 Test
//            //ca-app-pub-4602239242191301/6579910746 Prod
//            GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
//                               request: request,
//                               completionHandler: { [self] ad, error in
//                      if let error = error {
//                        print("Failed to load rewarded ad with error: \(error.localizedDescription)")
//                        return
//                      }
//                      rewardedAd = ad
//                      print("Rewarded ad loaded.")
//                    if let ad = rewardedAd {
//                      ad.present(fromRootViewController: self) {
//                        let reward = ad.adReward
//                        print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
//                        // TODO: Reward the user.
//                      }
//                    } else {
//                      print("Ad wasn't ready")
//                    }
//                }
//            )
//        } else if UserDefaults.standard.value(forKey: "ads") as? String == "1"{
//            let request = GADRequest()
//            GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
//                               request: request,
//                               completionHandler: { [self] ad, error in
//                  if let error = error {
//                    print("Failed to load rewarded ad with error: \(error.localizedDescription)")
//                    return
//                  }
//                  rewardedAd = ad
//                  print("Rewarded ad loaded.")
//                    if let ad = rewardedAd {
//                      ad.present(fromRootViewController: self) {
//                        let reward = ad.adReward
//                        print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
//                        // TODO: Reward the user.
//                      }
//                    } else {
//                      print("Ad wasn't ready")
//                    }
//                }
//            )
//        }
//        
//      }
//    
//    func show() {
//      
//    }
//    
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        print("Ad did fail to present full screen content.")
//      }
//
//      /// Tells the delegate that the ad will present full screen content.
//      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad will present full screen content.")
//      }
//
//      /// Tells the delegate that the ad dismissed full screen content.
//      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad did dismiss full screen content.")
//      }
//    
//}
//
//

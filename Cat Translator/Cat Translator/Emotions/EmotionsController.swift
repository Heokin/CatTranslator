//
//  EmotionsController.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import AVFAudio
import GoogleMobileAds

class EmotionsController: UIViewController {
    
    //MARK: Create UI
    
    let local = LocalizationVariables()
    
    var player: AVAudioPlayer?
    //var rewardedAd: GADRewardedAd?
    var oController = UserDefaults.standard.value(forKey: "oController")
    
    var catIconArray = [(image: String, text: String)]()
    
    let blue = ["Yes" , "Sad", "What", "Hungry", "Love"]
    let yellow = ["No" , "Yummy", "Sleepy", "Froze", "Attention", "Lonely"]
    let purple = ["Hello" , "Angry", "Happy", "Fear", "Suprised"]
    let textLow = ["No", "Buble", "Cry", "Froze", "Lonely", "Happy",
                   "Fear", "Attention", "Sleppy", "Amazed"]
    
    let oneOne = ["No", "Froze", "Lonely", "Fear", "Sleepy"]
    let twoOne = ["Hello" , "Angry", "Bath", "Suprised", "Yummy"]
    let longSound = ["Suprised", "Cry", "Sleepy", "Sad"]

    public var collection: UICollectionView?
    var selectedIndex: IndexPath?
    
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
    
    lazy var navigationView = View(type: .navigationView)
    lazy var navigationHeader = Label(type: .pageTitle, local.titleEmotions, "")
    lazy var navigationSetting = Button(type: .navigationSetting, nil)
    lazy var roundedSettingView = View(type: .roundedView)
    
    lazy var dismissView = View(type: .dismissView)
    lazy var dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleClose))
    lazy var chevron = ImageView(image: .chevronLeft)
    lazy var libraryDismisLabel = Label(type: .folderDismiss, local.titleTranslator, "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("didLoad")
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
        
        setupCatArray()
        setUpUI()
        setUpLogic()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
//        
//        setupCatArray()
//        setUpUI()
//        setUpLogic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        
        
        print("didAppear")
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

extension EmotionsController {
    
    func setupCatArray() {
        catIconArray = [
            (image: "yes", text: "Yes"),
            (image: "hello", text: "Hello"),
            (image: "no", text: "No"),
            (image: "bubbles", text: "Buble"),
            (image: "angry", text: "Angry"),
            (image: "sad", text: "Sad"),
            (image: "cry", text: "Cry"),
            (image: "froze", text: "Froze"),
            (image: "lonely", text: "Lonely"),
            (image: "happy", text: "Happy"),
            (image: "what", text: "What"),
            (image: "bath", text: "Bath"),
            (image: "fear", text: "Fear"),
            (image: "attention", text: "Attention"),
            (image: "hungry", text: "Hungry"),
            (image: "suprised", text: "Suprised"),
            (image: "sleep", text: "Sleepy"),
            (image: "amazed", text: "Amazed"),
            (image: "love", text: "Love"),
            (image: "yummy", text: "Yummy")
            
        ]
    }
}

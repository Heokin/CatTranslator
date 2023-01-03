//
//  NewGameController.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import UIKit
import SnapKit
import AVFAudio

class NewGameController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var cardModel = CardModel()
    var cardArray = [Card]()
    var firstIndexFlippedPathIndex:IndexPath?
    
    var player : AVAudioPlayer?
    
    var collectionView: UICollectionView!
    
    var score = UserDefaults.standard.value(forKey: "score")
    
    var level = UserDefaults.standard.value(forKey: "Level") as? Int ?? 1
    
    var supportUD = "0"
    var counter = 0
    var reloadFlag = 0
    
    
    var cellHeight = UIScreen.main.bounds.height / 6.7666
    var cellWidth = UIScreen.main.bounds.width / 4.6875
    
    let local = LocalizationVariables()
    lazy var navigationView = View(type: .navigationView)
    lazy var navigationHeader = Label(type: .pageTitle, local.gameButton, "")
    
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
    
    lazy var dismissView = View(type: .dismissView)
    lazy var dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleClose))
    lazy var chevron = ImageView(image: .chevronLeft)
    lazy var libraryDismisLabel = Label(type: .folderDismiss, local.titleTranslator, "")
    
    lazy var scoreView = View(type: .dismissView)
    lazy var scoreLabel = Label(type: .score, score as! String, "")
    lazy var scoreImage = ImageView(image: .score)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        switch(level) {
        case 1:  cardArray = cardModel.getCard()
        case 2:  cardArray = cardModel.getCardSecond()
        case 3:  cardArray = cardModel.getCardThird()
        default: cardArray = cardModel.getCard()
        }
        
        cardArray.shuffle()
        
        setUpUI()
        setUpLogic()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
}

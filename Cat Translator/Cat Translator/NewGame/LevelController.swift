//
//  GameAlert.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 21.12.22.
//

import Foundation
import UIKit
import Lottie

class LevelController: UIViewController {
    
    lazy var activityViewController: UIActivityViewController? = nil
    
    let local = LocalizationVariables()
    
    lazy var text = Label(type: .semibold30, local.congrats, "")
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundMain")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    var animationView: LottieAnimationView = {
            var animation = LottieAnimationView()
            animation = .init(name: "congrats")
            animation.animationSpeed = 1
            animation.loopMode = .loop
            animation.translatesAutoresizingMaskIntoConstraints = false
            animation.isUserInteractionEnabled = false
            return animation
        }()
    
    lazy var mainButton = Button(type: .mainLevel, local.mainLevel)
    lazy var levelButton = Button(type: .nextLevel, local.nextLevel)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
        view.addSubview(text)
        view.addSubview(animationView)
        view.addSubview(mainButton)
        view.addSubview(levelButton)
        
        text.textColor = UIColor(named: "purple")
        
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(301)
            make.width.equalTo(344)
        }
        
        text.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(animationView.snp.top).offset(-24)
        }
        
        mainButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-58)
            make.left.equalToSuperview().offset(UIScreen.main.bounds.width / 10.7142)
            make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
            make.height.equalTo(50)
        }

        levelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-58)
            make.right.equalToSuperview().offset(-UIScreen.main.bounds.width / 10.7142)
            make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
            make.height.equalTo(50)
        }
        
        animationView.play()
        mainButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        levelButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
    }
    
    @objc func handleClose(paramSander: Any){  // 2 seconds here
            let vc = TranslatorController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
    }
    
    @objc func handleNext(paramSander: Any){
        let vc = NewGameController()
        if UserDefaults.standard.value(forKey: "Level") as? Int == 1 {
            UserDefaults.standard.set(2, forKey: "Level")
        } else if UserDefaults.standard.value(forKey: "Level") as? Int == 2 {
            UserDefaults.standard.set(3, forKey: "Level")
        } else {
            UserDefaults.standard.set(1, forKey: "Level")
        }
        vc.level = UserDefaults.standard.value(forKey: "Level") as? Int ?? 1
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
}

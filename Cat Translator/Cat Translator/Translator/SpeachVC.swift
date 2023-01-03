//
//  SpeachVC.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 5.12.22.
//

import Foundation
import UIKit
import AVFAudio
import Lottie

class SpeachVC: UIViewController {
    
    var player: AVAudioPlayer?
    var durationVoice: Double?
    var delay: Double?
    
    var isHuman: Bool?
    let humanSay = ["Myau", "Mur", "fffff", "shhhhh", "Meoooooooow"]
    let catSay = ["Hi!", "Let's play!", "Eat!!!!!", "Sleep....."]
    let humanSound = ["meaw11", "meaw12", "No", "Yes", "Hello"]
    
    let humanSayLong = ["Myau Myau", "Mur Mur", "fffff fffff", "shhhhh shhhhh", "Meoooooow Meoooooow"]
    let catSayLong = ["Hi! Hi!", "Let's play! Let's play!", "Eat!!!!! Eat!!!!!", "Sleep..... Sleep....."]
    let humanSoundLong = ["meaw21", "meaw22"]
    
    let humanSayVeryLong = ["Myau Myau Myau", "Mur Mur Mur", "fffff fffff fffff", "shhhhh shhhhh shhhhh", "Meooooow Meooooow Meooooow"]
    let catSayVeryLong = ["Hi! Hi! Hi!", "Let's play! Let's play! Let's play!", "Eat!!!!! Eat!!!!! Eat!!!!!", "Sleep..... Sleep..... Sleep....."]
    let humanSoundVeryLong = ["meaw31", "meaw32"]
    
    let humanSayVeryVeryLong = ["Myau Myau Myau Myau", "Mur Mur Mur Mur", "fffff fffff fffff fffff", "shhhhh shhhhh shhhhh shhhhh", "Meoooooow Meooooow Meoooooow Meoooow"]
    let catSayVeryVeryLong = ["Hi! Hi! Hi! Hi!", "Let's play! Let's play! Let's play! Let's play!", "Eat!!!!! Eat!!!!! Eat!!!!! Eat!!!!!", "Sleep..... Sleep..... Sleep..... Sleep....."]
    let humanSoundVeryVeryLong = ["meaw41"]
    
    var animationView: LottieAnimationView = {
            var animation = LottieAnimationView()
            animation = .init(name: "cat")
            animation.animationSpeed = 0.6
            animation.loopMode = .loop
            animation.translatesAutoresizingMaskIntoConstraints = false
            animation.isUserInteractionEnabled = false
            return animation
        }()
    
    lazy var text = Label(type: .semibold30, "Some say", "")
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundMain")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(imageView)
        
        view.addSubview(text)
        
        view.addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(301)
            make.width.equalTo(344)
        }
        
        text.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(animationView.snp.top).offset(-24)
            make.left.right.equalToSuperview()
        }
        
        animationView.play()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        print(player?.volume)
        
        if durationVoice ?? 3 >= 10 {
            delay = 4.5
            
            if isHuman! {
                text.text = humanSayVeryVeryLong.randomElement()
                playSound(name: humanSoundVeryVeryLong.randomElement() ?? "No")
            } else {
                text.text = catSayVeryVeryLong.randomElement()
            }
        } else if durationVoice ?? 3 >= 5  &&  durationVoice ?? 3 < 10{
            delay = 3
            if isHuman! {
                text.text = humanSayVeryLong.randomElement()
                playSound(name: humanSoundVeryLong.randomElement() ?? "No")
            } else {
                text.text = catSayVeryLong.randomElement()
            }
        } else if durationVoice ?? 3 > 2 && durationVoice ?? 3 < 5 {
            delay = 3
            if isHuman! {
                text.text = humanSayLong.randomElement()
                playSound(name: humanSoundLong.randomElement() ?? "No")
            } else {
                text.text = catSayLong.randomElement()
            }
        } else {
            delay = 2
            if isHuman! {
                text.text = humanSay.randomElement()
                playSound(name: humanSound.randomElement() ?? "No")
            } else {
                text.text = catSay.randomElement()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 2)) {
            let vc = TranslatorController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
            
    }
    
    func playSound(name: String) {
                guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
                let url = URL(fileURLWithPath: path)

                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.prepareToPlay()
                    player?.play()
                    player?.volume = 1.0
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch(let error) {
                    print(error.localizedDescription)
            }
        }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

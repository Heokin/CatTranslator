//
//  SoundManager.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import Foundation
import AVFoundation

class SoundManager {
    
    
   static var audioPlayer :  AVAudioPlayer?
   
    
    enum soundEffect
    {
        case flip
        case shuffle
        case match
        case noMatch
    }
    
    
    static func playSound(_ effect : soundEffect)
    {
        var soundFileName = ""
        switch effect {
        case .flip:
            soundFileName = "open"
        case .match:
            soundFileName =  "match"
        case .noMatch:
            soundFileName = ""
        case .shuffle:
            soundFileName = ""
        default:
           soundFileName = ""
        }
  let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".mp3")
   
        guard bundlePath != nil else {
            print("no sound file path found")
            return
        }
        let soundURL   = URL(fileURLWithPath : bundlePath!)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.volume = 1.0
            audioPlayer?.enableRate = true
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
           
        }
        catch{
            print("cant play")
        }
    }
    
}

//
//  Button.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit

class Button: UIButton {
    
    let local = LocalizationVariables()
    
    enum ButtonType {
        case subscribeContinue
        case alertB
        case alertCancel
        case alertSetting
        case emotions
        case unlock
        case game
        case free
        case navigationSetting
        case navigationSubscribe
        case xmark
        case doneButton
        case mainLevel
        case nextLevel
    }
    
    init(type: ButtonType, _ text: String?) {
        
        
        
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
            
        case .doneButton:
            setTitle(text, for: .normal)
            titleLabel?.font = UIFont.rounded(ofSize: 17, weight: .semibold)
            setTitleColor(UIColor(named: "blue"), for: .normal)
            
        case .navigationSetting:
            setImage(UIImage(systemName: "gearshape"), for: .normal)
            tintColor = .white
            
        case .navigationSubscribe:
            setImage(UIImage(systemName: "crown"), for: .normal)
            tintColor = .white
            
        case .xmark:
            setImage(UIImage(systemName: "xmark"), for: .normal)
            tintColor = UIColor(named: "black")
            
        case .alertB:
            setTitle(text, for: .normal)
            setTitleColor(UIColor(red: 0, green: 0.591, blue: 0.917, alpha: 1), for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            backgroundColor = .clear
            
        case .alertSetting:
            setTitle(text, for: .normal)
            setTitleColor(UIColor(red: 0, green: 0.591, blue: 0.917, alpha: 1), for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            backgroundColor = .clear
            
        case .alertCancel:
            setTitle(text, for: .normal)
            setTitleColor(UIColor(red: 0.82, green: 0.384, blue: 0.514, alpha: 1), for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            backgroundColor = .clear
            
        case .subscribeContinue:
            setTitle(text, for: .normal)
            setTitleColor(UIColor.white, for: .normal)
            backgroundColor = UIColor(named: "purple")
            layer.cornerRadius = 14
            titleLabel?.font = UIFont.rounded(ofSize: 17, weight: .semibold)
            
        case .emotions:
            setTitle(text, for: .normal)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "emotionIcon")
            
            let imageSize = imageAttachment.image!.size
            imageAttachment.bounds = CGRect(x: CGFloat(0), y: ((titleLabel?.font.capHeight)! - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
                    
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: " " + local.emotionsButton))
            
            setAttributedTitle(fullString, for: .normal)
            
            backgroundColor = UIColor(named: "lightYellow")
            layer.cornerRadius = 14
            titleLabel?.font =  UIFont.rounded(ofSize: 17, weight: .semibold)
            titleLabel?.textColor = UIColor(named: "black")
            
        case .unlock:
            setTitle(text, for: .normal)
            
            
            let imageAttachment = NSTextAttachment()
            
            imageAttachment.image = UIImage(systemName: "crown")?.withTintColor(.white)
            //imageAttachment.setImageHeight(height: 50)

            let imageSize = imageAttachment.image!.size
            imageAttachment.bounds = CGRect(x: CGFloat(-30), y: ((titleLabel?.font.capHeight)! - imageSize.height) / 2, width: 51, height: 40)
                    
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: " " + local.unlockButton))
            
            setAttributedTitle(fullString, for: .normal)
            
            backgroundColor = UIColor(red: 0.51, green: 0.78, blue: 0.902, alpha: 1)
            layer.cornerRadius = 12
            titleLabel?.font =  UIFont.rounded(ofSize: 22, weight: .medium)
            titleLabel?.textColor = .white
            
        case .game:
            setTitle(text, for: .normal)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "gameIcon")
            
            let imageSize = imageAttachment.image!.size
            imageAttachment.bounds = CGRect(x: CGFloat(0), y: ((titleLabel?.font.capHeight)! - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
                    
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: " " + local.gameButton))
            
            setAttributedTitle(fullString, for: .normal)
            
            backgroundColor = UIColor(named: "lightBlue")
            layer.cornerRadius = 14
            titleLabel?.font =  UIFont.rounded(ofSize: 17, weight: .semibold)
            titleLabel?.textColor = UIColor(named: "black")
            
        case .mainLevel:
            setTitle(text, for: .normal)
            
            backgroundColor = UIColor(named: "pink")
            layer.cornerRadius = 14
            titleLabel?.font =  UIFont.rounded(ofSize: 17, weight: .semibold)
            titleLabel?.textColor = UIColor(named: "black")
        
        case .nextLevel:
            setTitle(text, for: .normal)
            
            backgroundColor = UIColor(named: "purple")
            layer.cornerRadius = 14
            titleLabel?.font =  UIFont.rounded(ofSize: 17, weight: .semibold)
            titleLabel?.textColor = UIColor(named: "black")
            
        case .free:
            setTitle(text, for: .normal)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "gift")
                    
            let fullString = NSMutableAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: " " + local.freeButton))
            
            setAttributedTitle(fullString, for: .normal)
            
            backgroundColor = UIColor(named: "purple")
            layer.cornerRadius = 14
            titleLabel?.font =  UIFont.rounded(ofSize: 20, weight: .medium)
            titleLabel?.textColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

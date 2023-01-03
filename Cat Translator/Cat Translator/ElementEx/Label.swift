//
//  Label.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit

class Label: UILabel {
    
    enum LabelType {
        
        case semibold30
        case semibold22
        case regular17
        case ads
        case subLabel
        case pageTitle
        case boardingHeader
        case subscribeHeader
        case subscribeTitle

        case folderDismiss
        case mainText
        case alertRate
        case alertText
        case alertRestore
        case alertRestoreDiscription
        case restore
        
        case subscribeTop
        case subscribeTopActive
        case subscribeTopPrice
        case subscribeTopPriceActive
        case subscribeBottomPrice
        case subscribeBottomPriceActive
        case subscribeBottom
        case subscribeBottomActive
        case priceBot
        case priceBotActive
        case priceTop
        case priceTopActive
        case dayBot
        case dayBotActive
        case dayTop
        case dayTopActive
        
        case score
    }
    
    let local = LocalizationVariables()
    
    var paragraphStyle = NSMutableParagraphStyle()
    
    init(type: LabelType, _ text: String?, _ subHelper: String?) {
        
        super.init(frame: .zero)
        self.text = text
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
            
        case .semibold30:
            textColor = UIColor(named: "black")
            font = UIFont.rounded(ofSize: 30, weight: .semibold)
            textAlignment = .center
            numberOfLines = 0
        case .semibold22:
            textColor = UIColor(named: "black")
            font = UIFont.rounded(ofSize: 22, weight: .semibold)
            textAlignment = .center
        case .regular17:
            textColor = UIColor(named: "grey")
            font = UIFont.rounded(ofSize: 17, weight: .regular)
            textAlignment = .center
        case .ads:
            textColor = .white
            font = UIFont.systemFont(ofSize: 37, weight: .semibold)
            textAlignment = .center
            centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        case .restore:
            textColor = UIColor(named: "grey")
            font = UIFont.rounded(ofSize: 17, weight: .medium)
        case .alertRate:
            font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            textAlignment = .center
            textColor = .white
            numberOfLines = 0
        case .alertText:
            font = UIFont.systemFont(ofSize: 13, weight: .regular)
            textAlignment = .center
            
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            paragraphStyle.lineHeightMultiple = 1.17
            paragraphStyle.alignment = .center

            numberOfLines = 0
            header = NSAttributedString(
                string: text!+"\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                             NSAttributedString.Key.paragraphStyle: paragraphStyle]
            )
            wayText = NSAttributedString(
                string: subHelper!,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                             NSAttributedString.Key.paragraphStyle: paragraphStyle]
            )
            
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
        case .subLabel:
            font = UIFont.rounded(ofSize: 22, weight: .medium)
            textAlignment = .center
            textColor = .white
            numberOfLines = 0
        case .pageTitle:
            font = UIFont.rounded(ofSize: 20, weight: .semibold)
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .boardingHeader:
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            paragraphStyle.lineHeightMultiple = 1.17
            
            font = UIFont.rounded(ofSize: 38, weight: .bold)
            textColor = .black
            numberOfLines = 0
            header = NSAttributedString(
                string: text!+"\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "purple"),
                             NSAttributedString.Key.paragraphStyle: paragraphStyle]
            )
            wayText = NSAttributedString(
                string: subHelper!,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "pink"),
                             NSAttributedString.Key.paragraphStyle: paragraphStyle]
            )
            
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
            
            textAlignment = .center
            
            centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        case .subscribeHeader:
            font = UIFont.rounded(ofSize: 36, weight: .semibold)
            textAlignment = .center
            textColor = UIColor(named: "purple")
            numberOfLines = 0
            lineBreakMode = .byWordWrapping
        case .subscribeTitle:
            font = UIFont.rounded(ofSize: 20, weight: .regular)
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeTopPrice:
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            if UIScreen.main.bounds.width > 500 {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 21, weight: .medium)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 23, weight: .semibold)]
                )
            } else {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 12, weight: .medium)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 14, weight: .semibold)]
                )
            }
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeTopPriceActive:
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            if UIScreen.main.bounds.width > 500 {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 22, weight: .medium)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 25, weight: .semibold)]
                )
            } else {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 13, weight: .medium)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 16, weight: .semibold)]
                )
            }
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
            textAlignment = .center
            textColor = .black
            numberOfLines = 0

        case .subscribeBottomPrice:
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            if UIScreen.main.bounds.width > 500 {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 27, weight: .semibold)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 22, weight: .medium)]
                )
            } else {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 18, weight: .semibold)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 13, weight: .medium)]
                )
            }
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeBottomPriceActive:
            let attString = NSMutableAttributedString()
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            if UIScreen.main.bounds.width > 500 {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 31, weight: .semibold)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 26, weight: .medium)]
                )
            } else {
                header = NSAttributedString(
                    string: text!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 22, weight: .semibold)]
                )
                wayText = NSAttributedString(
                    string: subHelper!,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.rounded(ofSize: 17, weight: .medium)]
                )
            }
            
            attString.append(header)
            attString.append(wayText)
            attributedText = attString
            textAlignment = .center
            textColor = .black
            numberOfLines = 0

        case .subscribeTop:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 23, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 14, weight: .medium)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeTopActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 25, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 16, weight: .medium)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeBottom:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 25, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 16, weight: .semibold)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .subscribeBottomActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 29, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 20, weight: .semibold)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .folderDismiss:
            font = UIFont.rounded(ofSize: 17, weight: .regular)
            textColor = UIColor(named: "orange")
            textAlignment = .left
        case .mainText:
            font = UIFont.systemFont(ofSize: 17, weight: .regular)
            textColor = .white
            textAlignment = .left
        case .alertRestore:
            font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            textAlignment = .center
            textColor = .white
            numberOfLines = 0
        case .alertRestoreDiscription:
            font = UIFont.systemFont(ofSize: 13, weight: .regular)
            textAlignment = .center
            paragraphStyle.lineHeightMultiple = 1.42
            paragraphStyle.alignment = .center
            textColor = .white
            numberOfLines = 0
            attributedText = NSMutableAttributedString(string: local.alertRestoreDiscription, attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        case .priceBot:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 27, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 18, weight: .semibold)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .priceBotActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 31, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 22, weight: .semibold)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .priceTop:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 25, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 16, weight: .medium)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .priceTopActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 29, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 20, weight: .medium)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .dayBot:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 25, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 16, weight: .semibold)
            }
            
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .dayBotActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 29, weight: .semibold)
            } else {
                font = UIFont.rounded(ofSize: 20, weight: .semibold)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .dayTop:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 23, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 14, weight: .medium)
            }
            
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .dayTopActive:
            if UIScreen.main.bounds.width > 500 {
                font = UIFont.rounded(ofSize: 25, weight: .medium)
            } else {
                font = UIFont.rounded(ofSize: 16, weight: .medium)
            }
            textAlignment = .center
            textColor = .black
            numberOfLines = 0
        case .score:
            font = UIFont.rounded(ofSize: 22, weight: .semibold)
            textAlignment = .right
            textColor = UIColor(named: "purple")
            numberOfLines = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}

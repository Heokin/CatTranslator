//
//  TranslatorUI.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit

extension TranslatorController {
    
    func setup() {
        
        view.addSubview(imageView)
        view.addSubview(navigationView)
        
        navigationView.addSubview(navigationHeader)
        navigationView.addSubview(roundedSettingView)
        navigationView.addSubview(roundedSubscribeView)
        
        roundedSettingView.backgroundColor = UIColor(named: "grey")
        roundedSubscribeView.backgroundColor = UIColor(named: "blue")
        
        roundedSettingView.addSubview(navigationSetting)
        roundedSubscribeView.addSubview(navigationSubscribe)
     
        
        view.backgroundColor = .white
        view.addSubview(vads)
        if baner != nil {
            vads.addSubview(baner!)
            baner?.snp.makeConstraints({ make in
                make.center.equalToSuperview()
            })
        }
        
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        //segment.backgroundColor = .red
        
        view.addSubview(segment)
        view.addSubview(emotionButton)
        view.addSubview(gameButton)
        view.addSubview(helpTextLabel)
        
        drawHuman()
        drawCat()
        microRingSetting()
        drawSquare()
        
        view.layer.addSublayer(thirdSquare)
        
        view.layer.addSublayer(trackShape)
        view.layer.addSublayer(subShape)
        
        view.layer.addSublayer(rect)
        view.layer.addSublayer(firstHalf)
        view.layer.addSublayer(secondHalf)
        view.layer.addSublayer(firstCircle)
        
        view.layer.addSublayer(firstSquare)
        view.layer.addSublayer(secondSquare)
        
        if isHuman {
            isHuman = true
            trackShape.isHidden = false
            subShape.isHidden = false
            firstHalf.isHidden = true
            secondHalf.isHidden = true
            firstCircle.isHidden = true
            rect.isHidden = true
            
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            header = NSAttributedString(
                string: local.textHelperCatFirst,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grey"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 17, weight: .regular)]
            )
            wayText = NSAttributedString(
                string: local.textHelperHuman,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grey"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 17, weight: .regular)]
            )
            
            let fullString = NSMutableAttributedString(string: "")
            fullString.append(header)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(systemName: "hand.raised.fill")?.withTintColor(UIColor(named: "grey")!)
            image1Attachment.bounds = CGRect(x: 0, y: -4, width: 24, height: 22)
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(wayText)
            
            let image2Attachment = NSTextAttachment()
            image2Attachment.image = UIImage(systemName: "mic.fill")?.withTintColor(UIColor(named: "grey")!)
            image2Attachment.bounds = CGRect(x: 0, y: -4, width: 20, height: 23)
            let image2String = NSAttributedString(attachment: image2Attachment)
            fullString.append(image2String)
            
            self.helpTextLabel.attributedText = fullString
            
        } else {
            isHuman = false
            trackShape.isHidden = true
            subShape.isHidden = true
            firstHalf.isHidden = false
            secondHalf.isHidden = false
            firstCircle.isHidden = false
            rect.isHidden = false
            
            var header: NSAttributedString!
            var wayText: NSAttributedString!
            
            header = NSAttributedString(
                string: local.textHelperCatFirst,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grey"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 17, weight: .regular)]
            )
            wayText = NSAttributedString(
                string: local.textHelperCatSecond,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grey"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 17, weight: .regular)]
            )

            
            let fullString = NSMutableAttributedString(string: "")
            fullString.append(header)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(systemName: "pawprint.fill")?.withTintColor(UIColor(named: "grey")!)
            image1Attachment.bounds = CGRect(x: 0, y: -4, width: 27, height: 22)
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(wayText)
            
            let image2Attachment = NSTextAttachment()
            image2Attachment.image = UIImage(systemName: "mic.fill")?.withTintColor(UIColor(named: "grey")!)
            image2Attachment.bounds = CGRect(x: 0, y: -4, width: 20, height: 23)
            let image2String = NSAttributedString(attachment: image2Attachment)
            fullString.append(image2String)
            
            self.helpTextLabel.attributedText = fullString
            
        }
        
        thirdSquare.isHidden = true
        secondSquare.isHidden = true
        firstSquare.isHidden = true
        ringMicro.isHidden = true
        
        view.layer.addSublayer(ringMicro)
        view.addSubview(micro)
        view.bringSubviewToFront(micro)
        
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        
        //segment.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.2)
        
        
        navigationSetting.addTarget(self, action: #selector(settingHandle), for: .touchUpInside)
        navigationSubscribe.addTarget(self, action: #selector(subHandle), for: .touchUpInside)
        
        emotionButton.addTarget(self, action: #selector(emotionVC), for: .touchDown)
        gameButton.addTarget(self, action: #selector(gameVC), for: .touchDown)
        
        NSLayoutConstraint.activate([
            
            vads.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vads.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
        ])
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(66)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(52)
        }
        
        navigationHeader.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(navigationView)
        }

        roundedSettingView.snp.makeConstraints { make in
            make.right.equalTo(navigationView)
            make.centerY.equalTo(navigationView)
        }

        roundedSubscribeView.snp.makeConstraints { make in
            make.left.equalTo(navigationView)
            make.centerY.equalTo(navigationView)
        }

        navigationSetting.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(roundedSettingView)
        }

        navigationSubscribe.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(roundedSubscribeView)
        }
        
        if UIScreen.main.bounds.height < 668 {
            emotionButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-18)
                make.left.equalToSuperview().offset(UIScreen.main.bounds.width / 10.7142)
                make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
                make.height.equalTo(50)
            }

            gameButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-18)
                make.right.equalToSuperview().offset(-UIScreen.main.bounds.width / 10.7142)
                make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
                make.height.equalTo(50)
            }
        } else {
            emotionButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-58)
                make.left.equalToSuperview().offset(UIScreen.main.bounds.width / 10.7142)
                make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
                make.height.equalTo(50)
            }

            gameButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-58)
                make.right.equalToSuperview().offset(-UIScreen.main.bounds.width / 10.7142)
                make.width.equalTo( UIScreen.main.bounds.width / 2.6041)
                make.height.equalTo(50)
            }
        }
        
        segment.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(84)
            make.width.equalTo(168)
            make.bottom.equalTo(emotionButton.snp.top).offset(-UIScreen.main.bounds.height / 12.6875)
        }
        
        if UIScreen.main.bounds.height < 668 {
            helpTextLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(segment.snp.top).offset(-20)
            }
        } else {
            
            helpTextLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(segment.snp.top).offset(-40)
            }
        }
        
        
        micro.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
}


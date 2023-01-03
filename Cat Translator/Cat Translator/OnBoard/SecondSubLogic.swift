//
//  SecondSubLogic.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 6.12.22.
//

import Foundation
import UIKit

extension SecondSubOnBoarding {
    
    func activeBottom(_ text: String, _ period: String) -> NSMutableAttributedString {
        let attString = NSMutableAttributedString()
        
        var header: NSAttributedString!
        var wayText: NSAttributedString!
        
        if UIScreen.main.bounds.width > 500 {
            header = NSAttributedString(
                string: text + "\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 22, weight: .medium)]
            )
            wayText = NSAttributedString(
                string: period,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 25, weight: .semibold)]
            )
        } else {
            header = NSAttributedString(
                string: text + "\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 13, weight: .medium)]
            )
            wayText = NSAttributedString(
                string: period,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 16, weight: .semibold)]
            )
        }
        
        attString.append(header)
        attString.append(wayText)
        
        return attString
    }
    
    func noActiveBottom(_ text: String, _ period: String) -> NSMutableAttributedString {
        let attString = NSMutableAttributedString()
        
        var header: NSAttributedString!
        var wayText: NSAttributedString!
        
        if UIScreen.main.bounds.width > 500 {
            header = NSAttributedString(
                string: text + "\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 21, weight: .medium)]
            )
            wayText = NSAttributedString(
                string: period,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 26, weight: .semibold)]
            )
        } else {
            header = NSAttributedString(
                string: text + "\n",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 12, weight: .medium)]
            )
            wayText = NSAttributedString(
                string: period,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "black"),
                             NSAttributedString.Key.font: UIFont.rounded(ofSize: 14, weight: .semibold)]
            )
        }
        
        attString.append(header)
        attString.append(wayText)
        
        
        
        return attString
    }
    
    func setupLogic() {
        
        dismissView.isHidden = true
        xmark.isHidden = true
        
        buttonDelay = UserDefaults.standard.value(forKey: "closeButtonDelay")
        print("some \(buttonDelay)")
        
        if buttonDelay == nil {
            buttonDelay = "0"
        }
        
        let _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(buttonDelay as! String)!, repeats: false) { [self] Timer in
            self.dismissView.isHidden = false
            self.xmark.isHidden = false
        }
    }
    
    @objc func firstSub() {
        
        UserDefaults.standard.set(first, forKey: "sub")
        
        firstSelectedSubView.isHidden = false
        firstSelectedTopLabel!.isHidden = false
        firstSelectedBottomLabel!.isHidden = false
        
        secondSubView.isHidden = false
        
        secondSelectedSubView.isHidden = true
        secondSelectedTopLabel!.isHidden = true
        secondSelectedBottomLabel!.isHidden = true
        
        thirdSelectedSubView.isHidden = true
        thirdSelectedTopLabel!.isHidden = true
        thirdSelectedBottomLabel!.isHidden = true
        
        
        let constraint = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.leadingAnchor.constraint(equalTo: firstSelectedSubView.trailingAnchor, constant: 8),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintSmall = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 6.5363),
            secondSubView.leadingAnchor.constraint(equalTo: firstSelectedSubView.trailingAnchor, constant: 8),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5.5),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 11),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintBig = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.trailingAnchor.constraint(equalTo: thirdSubView.leadingAnchor, constant: -50),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintMiddle = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.trailingAnchor.constraint(equalTo: thirdSubView.leadingAnchor, constant: -25),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        
        secondSubView.deactivateAllConstraints()
        
        if UIScreen.main.bounds.width > 830 {
            NSLayoutConstraint.activate(constraintBig)
        } else if UIScreen.main.bounds.width < 830 && UIScreen.main.bounds.width > 500 {
            NSLayoutConstraint.activate(constraintMiddle)
        } else if UIScreen.main.bounds.height < 668 {
            NSLayoutConstraint.activate(constraintSmall)
        } else {
            NSLayoutConstraint.activate(constraint)
        }
        
        
        
    }
    
    @objc func secondSub() {
        
        UserDefaults.standard.set(second, forKey: "sub")
        
        firstSelectedSubView.isHidden = true
        firstSelectedTopLabel!.isHidden = true
        firstSelectedBottomLabel!.isHidden = true
        
        secondSubView.isHidden = true
        
        secondSelectedSubView.isHidden = false
        secondSelectedTopLabel!.isHidden = false
        secondSelectedBottomLabel!.isHidden = false
        
        thirdSelectedSubView.isHidden = true
        thirdSelectedTopLabel!.isHidden = true
        thirdSelectedBottomLabel!.isHidden = true
        
    }
    
    @objc func thirdSub() {
        
        UserDefaults.standard.set(third, forKey: "sub")
        
        secondSubView.isHidden = false
        
        firstSelectedSubView.isHidden = true
        firstSelectedTopLabel!.isHidden = true
        firstSelectedBottomLabel!.isHidden = true
        
        secondSelectedSubView.isHidden = true
        secondSelectedTopLabel!.isHidden = true
        secondSelectedBottomLabel!.isHidden = true
        
        thirdSelectedSubView.isHidden = false
        thirdSelectedTopLabel!.isHidden = false
        thirdSelectedBottomLabel!.isHidden = false
        
        let constraint = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.trailingAnchor.constraint(equalTo: thirdSelectedSubView.leadingAnchor, constant: -8),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintSmall = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 6.5363),
            secondSubView.trailingAnchor.constraint(equalTo: thirdSelectedSubView.leadingAnchor, constant: -8),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5.5),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 11),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintBig = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.leadingAnchor.constraint(equalTo: firstSubView.trailingAnchor, constant: 50),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        let constraintMiddle = [
            secondSubView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height / 4.5363),
            secondSubView.leadingAnchor.constraint(equalTo: firstSubView.trailingAnchor, constant: 25),
            secondSubView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6.1984),
            secondSubView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondTopLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 0.5),
            secondTopLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondTopLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
            
            secondSubPlace.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12.3969),
            secondSubPlace.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.7128),
            
            secondBottomLabel!.heightAnchor.constraint(equalTo: secondSubView.heightAnchor, multiplier: 1.5),
            secondBottomLabel!.centerXAnchor.constraint(equalTo: secondSubView.centerXAnchor),
            secondBottomLabel!.widthAnchor.constraint(equalTo: secondSubView.widthAnchor),
        ]
        
        secondSubView.deactivateAllConstraints()
        
        if UIScreen.main.bounds.width > 830 {
            NSLayoutConstraint.activate(constraintBig)
        } else if UIScreen.main.bounds.width < 830 && UIScreen.main.bounds.width > 500 {
            NSLayoutConstraint.activate(constraintMiddle)
        } else if UIScreen.main.bounds.height < 668 {
            NSLayoutConstraint.activate(constraintSmall)
        } else {
            NSLayoutConstraint.activate(constraint)
        }
        
    }
    
    @objc func closeTarget() {
        let vc = TranslatorController()
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true)
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let vc = TranslatorController()
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true)
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    @objc func restoreTarget() {
        IAPManager.shared.restorePurchases()
    }
    
    @objc func restoreAlert(notification: Notification) {
        let alertController = UIAlertController(title: local.alertRestore,
                                                message: local.alertRestoreDiscription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: local.alertOk, style: .destructive))
        alertController.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        self.window?.rootViewController?.present(alertController, animated: true)
    }
    
}

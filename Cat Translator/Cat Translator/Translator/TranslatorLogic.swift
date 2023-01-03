//
//  TranslatorLogic.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import StoreKit
import MessageUI
import AVFoundation

extension TranslatorController {
    
    func microRingSetting() {
        
        ringMicro.path = ringMicroPath.cgPath
        ringMicro.fillColor = UIColor(named: "lightYellow")?.cgColor
        ringMicro.lineWidth = 3
        ringMicro.strokeEnd = 0.0
        ringMicro.strokeStart = 0.0
        ringMicro.strokeColor = UIColor.white.withAlphaComponent(0.6).cgColor
        ringMicro.lineCap = .round
        
    }
    
    func microRingAnimation() {
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 2.2
        pathAnimation.fromValue = NSNumber(value: 0.0)
        pathAnimation.toValue = NSNumber(value: 1.0)
        pathAnimation.repeatCount = Float.infinity
        pathAnimation.autoreverses = true
        ringMicro.add(pathAnimation, forKey: "strokeEnd")
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.duration = 1.5
        fillColorAnimation.fromValue = UIColor(red: 1, green: 0.831, blue: 0.741, alpha: 0.1).cgColor
        if isHuman {
            fillColorAnimation.toValue = UIColor(red: 1, green: 0.749, blue: 0.616, alpha: 1).cgColor
        } else {
            fillColorAnimation.toValue = UIColor(named: "purple")?.cgColor
        }
        fillColorAnimation.repeatCount = Float.infinity
        fillColorAnimation.autoreverses = true
        ringMicro.add(fillColorAnimation, forKey: "fillColor")
        
    }
    
    func animationHumanStart() {
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.duration = 1.5
        fillColorAnimation.fromValue = UIColor(red: 1, green: 0.831, blue: 0.741, alpha: 1).cgColor
        fillColorAnimation.toValue = UIColor(red: 1, green: 0.486, blue: 0.725, alpha: 1).cgColor
        fillColorAnimation.repeatCount = Float.infinity
        fillColorAnimation.autoreverses = true
        trackShape.speed = 1
        trackShape.fillMode = CAMediaTimingFillMode.forwards;
        trackShape.add(fillColorAnimation, forKey: "fillColor")
        
        let fillSubColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillSubColorAnimation.duration = 1.5
        fillSubColorAnimation.fromValue = UIColor(red: 1, green: 0.749, blue: 0.616, alpha: 1).cgColor
        fillSubColorAnimation.toValue = UIColor(red: 0.879, green: 0.476, blue: 0.704, alpha: 1).cgColor
        fillSubColorAnimation.repeatCount = Float.infinity
        fillSubColorAnimation.autoreverses = true
        subShape.speed = 1
        subShape.fillMode = CAMediaTimingFillMode.forwards;
        subShape.add(fillSubColorAnimation, forKey: "fillColor")
        
    }
    
    func animationCatStart() {
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.duration = 1.5
        fillColorAnimation.fromValue = UIColor(named: "purple")?.cgColor
        fillColorAnimation.toValue = UIColor(named: "pink")?.cgColor
        fillColorAnimation.repeatCount = Float.infinity
        fillColorAnimation.autoreverses = true
        firstHalf.speed = 1
        rect.speed = 1
        firstCircle.speed = 1
        firstHalf.add(fillColorAnimation, forKey: "fillColor")
        rect.add(fillColorAnimation, forKey: "fillColor")
        firstCircle.add(fillColorAnimation, forKey: "fillColor")
    }
    
    
    func drawCat() {
        
        firstHalf.path = firstHalfPath.cgPath
        firstHalf.fillColor = UIColor(named: "purple")?.cgColor
        firstHalf.lineWidth = 5
        firstHalf.strokeColor = UIColor(named: "black")?.cgColor
        firstHalf.lineCap = .round
        
        secondHalf.path = firstHalfPath.cgPath
        secondHalf.fillColor = UIColor.clear.cgColor
        secondHalf.lineWidth = 5
        secondHalf.strokeEnd = 0.0
        secondHalf.strokeStart = 0.0
        secondHalf.strokeColor = UIColor(red: 0.859, green: 0.29, blue: 0.267, alpha: 1).cgColor
        secondHalf.lineCap = .round
        
        firstCircle.path = firstCirclePath.cgPath
        firstCircle.fillColor = UIColor(named: "purple")?.cgColor
        firstCircle.lineWidth = 5
        firstCircle.strokeColor = UIColor(named: "black")?.cgColor
        firstCircle.lineCap = .round
        
        rect.path = rectPath.cgPath
        rect.fillColor = UIColor(named: "purple")?.cgColor
        rect.lineWidth = 5
        rect.strokeColor = UIColor.clear.cgColor
        rect.lineCap = .round
        
        
        
    }
    
//    func drawCatHelp() {
//        
//        firstHalfHelp.path = firstHalfPath.cgPath
//        firstHalfHelp.fillColor = UIColor(named: "purple")?.cgColor
//        firstHalfHelp.lineWidth = 5
//        firstHalfHelp.strokeColor = UIColor(named: "black")?.cgColor
//        firstHalfHelp.lineCap = .round
//        
//        secondHalfHelp.path = firstHalfPath.cgPath
//        secondHalfHelp.fillColor = UIColor.clear.cgColor
//        secondHalfHelp.lineWidth = 5
//        secondHalfHelp.strokeEnd = 0.0
//        secondHalfHelp.strokeStart = 0.0
//        secondHalfHelp.strokeColor = UIColor(red: 0.859, green: 0.29, blue: 0.267, alpha: 1).cgColor
//        secondHalfHelp.lineCap = .round
//        
//        firstCircleHelp.path = firstCirclePath.cgPath
//        firstCircleHelp.fillColor = UIColor(named: "purple")?.cgColor
//        firstCircleHelp.lineWidth = 5
//        firstCircleHelp.strokeColor = UIColor(named: "black")?.cgColor
//        firstCircleHelp.lineCap = .round
//        
//        rectHelp.path = rectPath.cgPath
//        rectHelp.fillColor = UIColor(named: "purple")?.cgColor
//        rectHelp.lineWidth = 5
//        rectHelp.strokeColor = UIColor.clear.cgColor
//        rectHelp.lineCap = .round
//    }
    
    func drawSquare() {
        
        firstPath.move(to: CGPoint(x: halfX + 60, y: halfY - 80))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 60, y: halfY - 70), controlPoint: CGPoint(x: halfX + 55, y: halfY - 75))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 80, y: halfY - 50), controlPoint: CGPoint(x: halfX + 70, y: halfY - 65))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 90, y: halfY - 50), controlPoint: CGPoint(x: halfX + 85, y: halfY - 45))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 110, y: halfY - 70), controlPoint: CGPoint(x: halfX + 100, y: halfY - 65))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 110, y: halfY - 80), controlPoint: CGPoint(x: halfX + 115, y: halfY - 75))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 90, y: halfY - 100), controlPoint: CGPoint(x: halfX + 100, y: halfY - 85))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 80, y: halfY - 100), controlPoint: CGPoint(x: halfX + 85, y: halfY - 105))
        firstPath.addQuadCurve(to: CGPoint(x: halfX + 60, y: halfY - 80), controlPoint: CGPoint(x: halfX + 70, y: halfY - 85))
        firstPath.close()
        
        firstSquare.path = firstPath.cgPath
        firstSquare.fillColor = UIColor(named: "lightYellow")?.cgColor
        firstSquare.lineWidth = 5
        firstSquare.strokeColor = UIColor(named: "black")?.cgColor
        firstSquare.lineCap = .round
        
        secondPath.move(to: CGPoint(x: halfX - 50, y: halfY - 160))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 50, y: halfY - 150), controlPoint: CGPoint(x: halfX - 45, y: halfY - 155))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 70, y: halfY - 130), controlPoint: CGPoint(x: halfX - 65, y: halfY - 140))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 80, y: halfY - 130), controlPoint: CGPoint(x: halfX - 75, y: halfY - 125))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 100, y: halfY - 150), controlPoint: CGPoint(x: halfX - 90, y: halfY - 145))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 100, y: halfY - 160), controlPoint: CGPoint(x: halfX - 105, y: halfY - 155))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 80, y: halfY - 180), controlPoint: CGPoint(x: halfX - 85, y: halfY - 170))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 70, y: halfY - 180), controlPoint: CGPoint(x: halfX - 75, y: halfY - 185))
        secondPath.addQuadCurve(to: CGPoint(x: halfX - 50, y: halfY - 160), controlPoint: CGPoint(x: halfX - 65, y: halfY - 170))
        secondPath.close()
        
        secondSquare.path = secondPath.cgPath
        secondSquare.fillColor = UIColor(named: "blue")?.cgColor
        secondSquare.lineWidth = 5
        secondSquare.strokeColor = UIColor(named: "black")?.cgColor
        secondSquare.lineCap = .round
        
        
        thirdPath.move(to: CGPoint(x: halfX - 35, y: halfY + 20))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 35, y: halfY + 30), controlPoint: CGPoint(x: halfX - 30, y: halfY + 25))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 55, y: halfY + 50), controlPoint: CGPoint(x: halfX - 50, y: halfY + 40))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 65, y: halfY + 50), controlPoint: CGPoint(x: halfX - 60, y: halfY + 55))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 85, y: halfY + 30), controlPoint: CGPoint(x: halfX - 80, y: halfY + 30))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 85, y: halfY + 20), controlPoint: CGPoint(x: halfX - 90, y: halfY + 25))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 65, y: halfY), controlPoint: CGPoint(x: halfX - 70, y: halfY + 15))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 55, y: halfY), controlPoint: CGPoint(x: halfX - 60, y: halfY - 5))
        thirdPath.addQuadCurve(to: CGPoint(x: halfX - 35, y: halfY + 20), controlPoint: CGPoint(x: halfX - 50, y: halfY + 15))
        thirdPath.close()
        
        thirdSquare.path = thirdPath.cgPath
        thirdSquare.fillColor = UIColor(red: 0.212, green: 0.835, blue: 0.612, alpha: 1).cgColor
        thirdSquare.lineWidth = 5
        thirdSquare.strokeColor = UIColor(named: "black")?.cgColor
        thirdSquare.lineCap = .round
        
    }
    
    func drawHuman() {
        
        freeform.move(to: CGPoint(x: halfX-25, y: halfY + 40))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 90, y: halfY - 40), controlPoint: CGPoint(x: halfX - 45, y: halfY + 35))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 105, y: halfY - 85), controlPoint: CGPoint(x: halfX - 110, y: halfY - 85))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 60, y: halfY - 70), controlPoint: CGPoint(x: halfX - 90, y: halfY - 110))
        freeform.addLine(to: CGPoint(x: halfX - 60, y: halfY - 150))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 42, y: halfY - 162), controlPoint: CGPoint(x: halfX - 60, y: halfY - 160))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 25, y: halfY - 150), controlPoint: CGPoint(x: halfX - 25, y: halfY - 160))
        freeform.addLine(to: CGPoint(x: halfX - 25, y: halfY - 80))
        freeform.addLine(to: CGPoint(x: halfX - 25, y: halfY - 170))
        freeform.addQuadCurve(to: CGPoint(x: halfX - 7, y: halfY - 182), controlPoint: CGPoint(x: halfX - 25, y: halfY - 180))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 10, y: halfY - 170), controlPoint: CGPoint(x: halfX + 10, y: halfY - 180))
        freeform.addLine(to: CGPoint(x: halfX + 10, y: halfY - 85))
        freeform.addLine(to: CGPoint(x: halfX + 10, y: halfY - 160))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 28, y: halfY - 172), controlPoint: CGPoint(x: halfX + 10, y: halfY - 170))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 45, y: halfY - 160), controlPoint: CGPoint(x: halfX + 45, y: halfY - 170))
        freeform.addLine(to: CGPoint(x: halfX + 45, y: halfY - 80))
        freeform.addLine(to: CGPoint(x: halfX + 45, y: halfY - 150))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 63, y: halfY - 162), controlPoint: CGPoint(x: halfX + 45, y: halfY - 160))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 80, y: halfY - 150), controlPoint: CGPoint(x: halfX + 80, y: halfY - 160))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 75, y: halfY + 10), controlPoint: CGPoint(x: halfX + 80, y: halfY))
        //freeform.addLine(to: CGPoint(x: halfX + 78, y: halfY + 20))
        freeform.addQuadCurve(to: CGPoint(x: halfX + 30, y: halfY + 40), controlPoint: CGPoint(x: halfX + 65, y: halfY + 40))
        freeform.close()
        
        trackShape.path = freeform.cgPath
        trackShape.fillColor = UIColor(red: 1, green: 0.831, blue: 0.741, alpha: 1).cgColor
        trackShape.lineWidth = 5
        trackShape.strokeColor = UIColor(named: "black")?.cgColor
        trackShape.lineCap = .round
        
        subform.move(to: CGPoint(x: halfX-22, y: halfY + 37))
        subform.addQuadCurve(to: CGPoint(x: halfX - 88, y: halfY - 42), controlPoint: CGPoint(x: halfX - 43.5, y: halfY + 36))
        subform.addQuadCurve(to: CGPoint(x: halfX - 103, y: halfY - 82.5), controlPoint: CGPoint(x: halfX - 107, y: halfY - 82.5))
        subform.addQuadCurve(to: CGPoint(x: halfX - 57, y: halfY - 63), controlPoint: CGPoint(x: halfX - 90, y: halfY - 108))
        subform.addLine(to: CGPoint(x: halfX - 57.5, y: halfY - 147))
        subform.addQuadCurve(to: CGPoint(x: halfX - 42, y: halfY - 159), controlPoint: CGPoint(x: halfX - 57.5, y: halfY - 159))
        subform.addQuadCurve(to: CGPoint(x: halfX + 20, y: halfY + 37), controlPoint: CGPoint(x: halfX - 37, y: halfY))
        subform.close()

        
        subShape.path = subform.cgPath
        subShape.fillColor = UIColor(red: 1, green: 0.749, blue: 0.616, alpha: 1).cgColor
        subShape.lineWidth = 10
        subShape.strokeColor = UIColor.clear.cgColor
        subShape.lineCap = .round
    }
    
//    func drawHumanHelp() {
//
//        freeform.move(to: CGPoint(x: halfX-25, y: halfY + 40))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 90, y: halfY - 40), controlPoint: CGPoint(x: halfX - 45, y: halfY + 35))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 105, y: halfY - 85), controlPoint: CGPoint(x: halfX - 110, y: halfY - 85))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 60, y: halfY - 70), controlPoint: CGPoint(x: halfX - 90, y: halfY - 110))
//        freeform.addLine(to: CGPoint(x: halfX - 60, y: halfY - 150))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 42, y: halfY - 162), controlPoint: CGPoint(x: halfX - 60, y: halfY - 160))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 25, y: halfY - 150), controlPoint: CGPoint(x: halfX - 25, y: halfY - 160))
//        freeform.addLine(to: CGPoint(x: halfX - 25, y: halfY - 80))
//        freeform.addLine(to: CGPoint(x: halfX - 25, y: halfY - 170))
//        freeform.addQuadCurve(to: CGPoint(x: halfX - 7, y: halfY - 182), controlPoint: CGPoint(x: halfX - 25, y: halfY - 180))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 10, y: halfY - 170), controlPoint: CGPoint(x: halfX + 10, y: halfY - 180))
//        freeform.addLine(to: CGPoint(x: halfX + 10, y: halfY - 85))
//        freeform.addLine(to: CGPoint(x: halfX + 10, y: halfY - 160))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 28, y: halfY - 172), controlPoint: CGPoint(x: halfX + 10, y: halfY - 170))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 45, y: halfY - 160), controlPoint: CGPoint(x: halfX + 45, y: halfY - 170))
//        freeform.addLine(to: CGPoint(x: halfX + 45, y: halfY - 80))
//        freeform.addLine(to: CGPoint(x: halfX + 45, y: halfY - 150))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 63, y: halfY - 162), controlPoint: CGPoint(x: halfX + 45, y: halfY - 160))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 80, y: halfY - 150), controlPoint: CGPoint(x: halfX + 80, y: halfY - 160))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 75, y: halfY + 10), controlPoint: CGPoint(x: halfX + 80, y: halfY))
//        //freeform.addLine(to: CGPoint(x: halfX + 78, y: halfY + 20))
//        freeform.addQuadCurve(to: CGPoint(x: halfX + 30, y: halfY + 40), controlPoint: CGPoint(x: halfX + 65, y: halfY + 40))
//        freeform.close()
//
//        trackShape.path = freeform.cgPath
//        trackShape.fillColor = UIColor(red: 1, green: 0.831, blue: 0.741, alpha: 1).cgColor
//        trackShape.lineWidth = 5
//        trackShape.strokeColor = UIColor(named: "black")?.cgColor
//        trackShape.lineCap = .round
//
//        subform.move(to: CGPoint(x: halfX-22, y: halfY + 37))
//        subform.addQuadCurve(to: CGPoint(x: halfX - 88, y: halfY - 42), controlPoint: CGPoint(x: halfX - 43.5, y: halfY + 36))
//        subform.addQuadCurve(to: CGPoint(x: halfX - 103, y: halfY - 82.5), controlPoint: CGPoint(x: halfX - 107, y: halfY - 82.5))
//        subform.addQuadCurve(to: CGPoint(x: halfX - 57, y: halfY - 63), controlPoint: CGPoint(x: halfX - 90, y: halfY - 108))
//        subform.addLine(to: CGPoint(x: halfX - 57.5, y: halfY - 147))
//        subform.addQuadCurve(to: CGPoint(x: halfX - 42, y: halfY - 159), controlPoint: CGPoint(x: halfX - 57.5, y: halfY - 159))
//        subform.addQuadCurve(to: CGPoint(x: halfX + 20, y: halfY + 37), controlPoint: CGPoint(x: halfX - 37, y: halfY))
//        subform.close()
//
//
//        subShape.path = subform.cgPath
//        subShape.fillColor = UIColor(red: 1, green: 0.749, blue: 0.616, alpha: 1).cgColor
//        subShape.lineWidth = 10
//        subShape.strokeColor = UIColor.clear.cgColor
//        subShape.lineCap = .round
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let tap = touches.first?.location(in: self.view)
        if tap!.y < halfY + 40 && tap!.y > halfY - 180 && tap!.x < halfX + 80 && tap!.x > halfX - 110 {
            tapActivate = true
            switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .denied, .restricted:
                alertPermission()
            case .authorized, .notDetermined:
                    if isHuman {
                        
                        recorder.record(self)
                        recorder.startMonitoring()
                        animationHumanStart()
                        micro.image = UIImage(named: "microAct")
                        
                    } else {
                        
                        recorder.record(self)
                        recorder.startMonitoring()
                        animationCatStart()
                        micro.image = UIImage(named: "microAct")
                    }
                
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .denied, .notDetermined:
            print("den")
        case .restricted, .authorized:
            if tapActivate {
                recorder.stop()
                recorder.stopMonitoring()
                
                micro.image = UIImage(named: "micro")
                
               
                if isHuman {
                    trackShape.removeAllAnimations()
                    subShape.removeAllAnimations()

                } else {
                    secondHalf.removeAllAnimations()
                    firstHalf.removeAllAnimations()
                    rect.removeAllAnimations()
                    firstCircle.removeAllAnimations()
                }
                
                if maxDecibel > 55 && timeDecibel >= 0.5 {
                    micro.image = UIImage(named: "microAct")
                    if isHuman {
                        var helper = UserDefaults.standard.value(forKey: "freeHuman") as? Int
                        helper! += 1
                        UserDefaults.standard.set(helper, forKey: "freeHuman")
                        if UserDefaults.standard.value(forKey: "FullAccess") as? Int == 1 { helper = 0 }
                        var value = UserDefaults.standard.value(forKey: "availableFreeHuman")
                        if value == nil {
                            value = "20"
                        }
                        if helper! > Int(value as! String)! || Int(value as! String)! == 0 {
                            var oController = "1"
                            if UserDefaults.standard.value(forKey: "oController") as? String != nil {
                                oController = UserDefaults.standard.value(forKey: "oController") as! String
                            } else {
                                oController = "2"
                            }
                            if oController == "0" {
                        
                            } else if oController == "1" {
                                let vc = FirstSubscribeViewController()
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            } else {
                                let vc = SecondSubscribeViewController()
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                            }
                        } else {

                                thirdSquare.isHidden = false
                                secondSquare.isHidden = false
                                firstSquare.isHidden = false
                            microRingAnimation()
                            ringMicro.isHidden = false
                            
                            let delay : Double = 2.0    // 2 seconds here
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [self] in
                                let vc = SpeachVC()
                                vc.isHuman = self.isHuman
                                vc.durationVoice = Double(timeDecibel)
                                vc.modalPresentationStyle = .fullScreen
                                present(vc, animated: false)
                                thirdSquare.isHidden = true
                                secondSquare.isHidden = true
                                firstSquare.isHidden = true
                                ringMicro.isHidden = true
                                ringMicro.removeAllAnimations()
                            }
                        }
                    } else {
                            var helper = UserDefaults.standard.value(forKey: "freeCat") as! Int
                            helper += 1
                            UserDefaults.standard.set(helper, forKey: "freeCat")
                            if UserDefaults.standard.value(forKey: "FullAccess") as! Int == 1 { helper = 0 }
                            var value = UserDefaults.standard.value(forKey: "availableFreeCat")
                            if value == nil {
                                value = "20"
                            }
                            if helper > Int(value as! String)! || Int(value as! String)! == 0 {
                                var oController = "1"
                                if UserDefaults.standard.value(forKey: "oController") as? String != nil {
                                    oController = UserDefaults.standard.value(forKey: "oController") as! String
                                } else {
                                    oController = "2"
                                }
                                if oController == "0" {
                            
                                } else if oController == "1" {
                                    let vc = FirstSubscribeViewController()
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                } else {
                                    let vc = SecondSubscribeViewController()
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                }
                            } else {

                                microRingAnimation()
                                ringMicro.isHidden = false
                                
                                let delay : Double = 2.0    // 2 seconds here
                                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [self] in
                                    let vc = SpeachVC()
                                    vc.isHuman = self.isHuman
                                    vc.durationVoice = Double(timeDecibel)
                                    vc.modalPresentationStyle = .fullScreen
                                    present(vc, animated: false)
                                    thirdSquare.isHidden = true
                                    secondSquare.isHidden = true
                                    firstSquare.isHidden = true
                                    ringMicro.isHidden = true
                                    ringMicro.removeAllAnimations()
                                }
                            }
                        }
                } else {
                    alertRecognize()
                    
                }
                tapActivate = false
            }
            
        }
    }
    
    
    func alertRecognize() {
        if isHuman {
            //trackShape.speed = 0
            trackShape.removeAllAnimations()
            //subShape.speed = 0
            subShape.removeAllAnimations()
            
            trackShape.isHidden = false
            subShape.isHidden = false
            
            secondHalf.isHidden = true
            firstHalf.isHidden = true
            rect.isHidden = true
            firstCircle.isHidden = true

        } else {
            
            trackShape.isHidden = true
            subShape.isHidden = true
            
            secondHalf.isHidden = false
            firstHalf.isHidden = false
            rect.isHidden = false
            firstCircle.isHidden = false
            
            secondHalf.removeAllAnimations()
            //secondHalf.speed = 0
            firstHalf.removeAllAnimations()
            //firstHalf.speed = 0
            rect.removeAllAnimations()
            //rect.speed = 0
            firstCircle.removeAllAnimations()
            //firstCircle.speed = 0
        }
        recorder.stop()
        recorder.stopMonitoring()
        let vc = AlertRecognize()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func alertPermission() {
        
        if isHuman {
            //trackShape.speed = 0
            trackShape.removeAllAnimations()
            //subShape.speed = 0
            subShape.removeAllAnimations()
            
            trackShape.isHidden = false
            subShape.isHidden = false
            
            secondHalf.isHidden = true
            firstHalf.isHidden = true
            rect.isHidden = true
            firstCircle.isHidden = true

        } else {
            
            trackShape.isHidden = true
            subShape.isHidden = true
            
            secondHalf.isHidden = false
            firstHalf.isHidden = false
            rect.isHidden = false
            firstCircle.isHidden = false
            
            secondHalf.removeAllAnimations()
            //secondHalf.speed = 0
            firstHalf.removeAllAnimations()
            //firstHalf.speed = 0
            rect.removeAllAnimations()
            //rect.speed = 0
            firstCircle.removeAllAnimations()
            //firstCircle.speed = 0
        }
        recorder.stop()
        recorder.stopMonitoring()
        
        let vc = AlertPermission()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @objc func emotionVC() {
        let vc = EmotionsController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func gameVC() {
        let vc = NewGameController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
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
            
            sender.setImage(UIImage(named: "catIcon")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
            sender.setImage(UIImage(named: "humanIconActive")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
            
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
            
            sender.setImage(UIImage(named: "catIconActive")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
            sender.setImage(UIImage(named: "humanIcon")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
            
        }
    }
    
    @objc func settingHandle() {
        let vc = SettingViewController()
        self.present(vc, animated: true)
    }
    
    @objc func subHandle() {
        oController = UserDefaults.standard.value(forKey: "oController")
        print(oController)
        if oController as? String == "1" {
            let vc = FirstSubscribeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else if oController as? String == "0" {
            
        }
        else {
            let vc = SecondSubscribeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    func rate() {
        
        let alert = UIAlertController(title: local.alertRate,
                                      message: "",
                                      preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        let cancelAlertButton = UIAlertAction(title: local.alertNo, style: .default) {
            [self] UIAlertAction in
            support()
        }
        let saveAlertButton = UIAlertAction(title: local.alertYes, style: .default) { _ in
            SKStoreReviewController.requestReview()
        }
        alert.addAction(cancelAlertButton)
        alert.addAction(saveAlertButton)
        present(alert, animated: true)
        
    }
    
    func support() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.overrideUserInterfaceStyle = .light
            let systemVersion = UIDevice.current.systemVersion
            let devicename = UIDevice.modelName
            let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            
            mail.setToRecipients(["support@mindateq.io"])
            mail.setSubject("Cat Translator — User Question ")
            mail.setMessageBody("<p></p><p>----------------</p><p> Device: \(devicename)</p><p>iOS: \(systemVersion)</p><p>App version: \(appVersion!) (\(buildNumber))</p>", isHTML: true)
            present(mail, animated: true)
        } else { }
        
    }
    
    
    
}

extension CALayer {
    var areAnimationsEnabled: Bool {
        get { delegate == nil }
        set { delegate = newValue ? nil : CALayerAnimationsDisablingDelegate.shared }
    }
}

private class CALayerAnimationsDisablingDelegate: NSObject, CALayerDelegate {
    static let shared = CALayerAnimationsDisablingDelegate()
    private let null = NSNull()

    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        null
    }
}

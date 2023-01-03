//
//  RecorderExtention.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 18.12.22.
//

import Foundation
import UIKit
import AVFoundation

extension TranslatorController: AVAudioRecorderDelegate, RecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // FIXME: Unusual
    }
    
    func recorderDidFailToAchievePermission(_ recorder: Recorder) {
        let alertController = UIAlertController(
            title: NSLocalizedString("Microphone", comment: ""),
            message: NSLocalizedString("SetMicro", comment: ""),
            preferredStyle: .alert
        )
        
        let cancelButton = UIAlertAction(
            title: NSLocalizedString("Cancel", comment: ""),
            style: .cancel,
            handler: nil
        )
        
        let settingsAction = UIAlertAction(
            title: NSLocalizedString("Settings", comment: ""),
            style: .default
        ) { _ in
            UIApplication.shared.open(
                URL(string: UIApplication.openSettingsURLString)!,
                options: [:],
                completionHandler: nil)
        }
        
        alertController.addAction(cancelButton)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func recorder(_ recorder: Recorder, didCaptureDecibels decibels: Int) {
        
        if maxDecibel < decibels {
            maxDecibel = decibels
        }
        
//        if f {
//            timeDecibel = Double(recorder.seconds) - 0.5
//            f = false
//        } else {
//            timeDecibel = Double(recorder.seconds)
//            f = true
//        }
        
        timeDecibel = recorder.seconds
    
        
        
        print(decibels)
        print(recorder.seconds)
     
    }
}

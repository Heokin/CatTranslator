//
//  CustomAlertPermisions.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 18.12.22.
//

import Foundation
import UIKit

class AlertPermission: UIViewController {
    
    lazy var activityViewController: UIActivityViewController? = nil
    
    let local = LocalizationVariables()
    
    lazy var header = Label(type: .alertText, local.alertMicrophonePermission, local.alertPermissionDenied)
    lazy var viewBoard = UIView()
    lazy var img = ImageView(image: .nothing)
    lazy var cancel = Button(type: .alertCancel, local.alertCancel)
    lazy var setting = Button(type: .alertSetting, local.alertSetting)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewBoard)
        
        view.backgroundColor = UIColor(red: 0.046, green: 0.046, blue: 0.046, alpha: 0.4)
        
        viewBoard.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 0.8)
        img.image = UIImage(named: "music")
        
        viewBoard.applyBlurEffect()
        viewBoard.translatesAutoresizingMaskIntoConstraints = false
        
        viewBoard.addSubview(header)
        viewBoard.addSubview(img)
        viewBoard.addSubview(setting)
        viewBoard.addSubview(cancel)
        setting.addTopBorder(with: UIColor(red: 0.29, green: 0.294, blue: 0.306, alpha: 1), andWidth: 0.5)
        cancel.addTopBorder(with: UIColor(red: 0.29, green: 0.294, blue: 0.306, alpha: 1), andWidth: 0.5)
        setting.addLeftBorder(with: UIColor(red: 0.29, green: 0.294, blue: 0.306, alpha: 1), andWidth: 0.5)
       
        viewBoard.layer.cornerRadius = 14
        
        cancel.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        setting.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            viewBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBoard.heightAnchor.constraint(equalToConstant: 248),
            viewBoard.widthAnchor.constraint(equalToConstant: 270),
            
            img.topAnchor.constraint(equalTo: viewBoard.topAnchor, constant: 16),
            img.centerXAnchor.constraint(equalTo: viewBoard.centerXAnchor),
            
            header.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            header.centerXAnchor.constraint(equalTo: viewBoard.centerXAnchor),
            
            cancel.widthAnchor.constraint(equalToConstant: 135),
            cancel.heightAnchor.constraint(equalToConstant: 44),
            cancel.leadingAnchor.constraint(equalTo: viewBoard.leadingAnchor),
            cancel.bottomAnchor.constraint(equalTo: viewBoard.bottomAnchor),
            
            setting.widthAnchor.constraint(equalToConstant: 135),
            setting.heightAnchor.constraint(equalToConstant: 44),
            setting.trailingAnchor.constraint(equalTo: viewBoard.trailingAnchor),
            setting.bottomAnchor.constraint(equalTo: viewBoard.bottomAnchor),
        ])
    }
    
    @objc func handleClose(paramSander: Any){
        dismiss(animated: false, completion: nil)
    }
    
    @objc func handleSetting(paramSander: Any){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in
            })
        }
    }
    
    
    
    
}

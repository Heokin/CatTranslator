//
//  CustomAlert.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit

class AlertRecognize: UIViewController {
    
    lazy var activityViewController: UIActivityViewController? = nil
    
    let local = LocalizationVariables()
    
    lazy var header = Label(type: .alertText, local.alertRecognizeHeader, local.alertRecognizeText)
    lazy var viewBoard = UIView()
    lazy var img = ImageView(image: .nothing)
    lazy var ok = Button(type: .alertB, local.alertOk)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewBoard)
        
        view.backgroundColor = UIColor(red: 0.046, green: 0.046, blue: 0.046, alpha: 0.4)
        
        viewBoard.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 0.8)
        img.image = UIImage(named: "what")
        
        viewBoard.applyBlurEffect()
        viewBoard.translatesAutoresizingMaskIntoConstraints = false
        
        viewBoard.addSubview(header)
        viewBoard.addSubview(img)
        viewBoard.addSubview(ok)
        ok.addTopBorder(with: UIColor(red: 0.29, green: 0.294, blue: 0.306, alpha: 1), andWidth: 0.5)
       
        viewBoard.layer.cornerRadius = 14
        
        ok.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            viewBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBoard.heightAnchor.constraint(equalToConstant: 185),
            viewBoard.widthAnchor.constraint(equalToConstant: 270),
            
            img.topAnchor.constraint(equalTo: viewBoard.topAnchor, constant: 16),
            img.centerXAnchor.constraint(equalTo: viewBoard.centerXAnchor),
            
            header.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            header.centerXAnchor.constraint(equalTo: viewBoard.centerXAnchor),
            
            ok.widthAnchor.constraint(equalToConstant: 270),
            ok.heightAnchor.constraint(equalToConstant: 44),
            ok.bottomAnchor.constraint(equalTo: viewBoard.bottomAnchor),
            ok.leadingAnchor.constraint(equalTo: viewBoard.leadingAnchor),
        
        ])
    }
    
    @objc func handleClose(paramSander: Any){
        dismiss(animated: false, completion: nil)
    }
    
    
}


extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}

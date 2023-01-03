//
//  SettingUI.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import SnapKit

extension SettingViewController {
    
    func setup() {
        
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(header)
        view.addSubview(done)
        view.addSubview(tabbleView)
        view.addSubview(subView)
        subView.addSubview(subImage)
        subView.addSubview(subLabel)
        tabbleView.backgroundColor = .clear
        tabbleView.layer.cornerRadius = 7
        
        done.addTarget(self, action: #selector(dismis), for: .touchUpInside)
        subView.addGestureRecognizer(subTap)
        //subButton.addTarget(self, action: #selector(sub), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            done.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            done.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            tabbleView.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 33),
            tabbleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tabbleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tabbleView.heightAnchor.constraint(equalToConstant: 352),
        ])
        
        if UserDefaults.standard.value(forKey: "FullAccess") as? Int == 1 {
            subView.isHidden = true
            tabbleView.snp.remakeConstraints { make in
                make.top.equalTo(header.snp.bottom).offset(38)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-15)
                make.height.equalTo(352)
            }
        }
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(38)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(80)
        }
        
        subImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.equalTo(51)
            make.height.equalTo(40)
            
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(subImage.snp.right).offset(16)
        }
    }
    
    
}

extension SettingViewController {
    
    @objc func dismis() {
        dismiss(animated: true)
    }
    
    @objc func sub() {
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
    
}


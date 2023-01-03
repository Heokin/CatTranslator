//
//  EmotionsUI.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import SnapKit

extension EmotionsController {
    
    func setUpUI() {
        
        view.backgroundColor = .white
        
        roundedSettingView.backgroundColor = UIColor(named: "grey")

        view.addSubview(imageView)
        view.addSubview(navigationView)
        
        navigationView.addSubview(navigationHeader)
        navigationView.addSubview(roundedSettingView)
        
        roundedSettingView.addSubview(navigationSetting)
        roundedSettingView.bringSubviewToFront(navigationSetting)
        
        navigationView.addSubview(dismissView)
        dismissView.addGestureRecognizer(dismissTap)
        dismissView.addSubview(chevron)
        dismissView.addSubview(libraryDismisLabel)
        
        libraryDismisLabel.textColor = UIColor(named: "blue")
        chevron.tintColor = UIColor(named: "blue")
        
        navigationSetting.addTarget(self, action: #selector(setting), for: .touchUpInside)
     
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(52)
        }
        
        dismissView.snp.makeConstraints { make in
            make.centerY.equalTo(navigationView.snp.centerY)
            make.left.equalTo(view).inset(0)
        }
        
        
        chevron.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18)
        }
        
        libraryDismisLabel.snp.makeConstraints { make in
            make.left.equalTo(chevron.snp.right).offset(8)
            make.centerY.equalTo(chevron.snp.centerY)
            make.right.equalToSuperview()
        }
        
        
        navigationHeader.snp.makeConstraints { make in
            make.center.equalTo(navigationView)
        }
//
        roundedSettingView.snp.makeConstraints { make in
            make.right.equalTo(navigationView)
            make.centerY.equalTo(navigationView)
        }


        navigationSetting.snp.makeConstraints { make in
            make.center.equalTo(roundedSettingView)
        }

    }
}

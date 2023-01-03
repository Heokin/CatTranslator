//
//  NewGameControllerUI.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import Foundation
import UIKit
import SnapKit


extension NewGameController {
    
    func setUpUI() {
        
        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(navigationView)
        
        navigationView.addSubview(navigationHeader)
        navigationView.addSubview(scoreView)
        
        navigationView.addSubview(dismissView)
        dismissView.addGestureRecognizer(dismissTap)
        dismissView.addSubview(chevron)
        dismissView.addSubview(libraryDismisLabel)
        
        scoreView.addSubview(scoreImage)
        scoreView.addSubview(scoreLabel)
        
        libraryDismisLabel.textColor = UIColor(named: "blue")
        chevron.tintColor = UIColor(named: "blue")
        
     
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(52)
        }
        
        navigationHeader.snp.makeConstraints { make in
            make.center.equalTo(navigationView)
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
        
        NSLayoutConstraint.activate([
            scoreView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scoreView.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            scoreView.heightAnchor.constraint(equalToConstant: 100),
            scoreView.widthAnchor.constraint(equalToConstant: 100),
            
            scoreImage.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
            scoreImage.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor, constant: -16),
            
            scoreLabel.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: scoreImage.leadingAnchor, constant: -8),
        ])
        
    }
}

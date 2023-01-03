//
//  CardCollectionViewCell.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import Foundation
import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var backImageView: UIImageView!
    var frontImageView: UIImageView!
    var level = UserDefaults.standard.value(forKey: "Level") as? Int ?? 1
    var card : Card?
    static let id = "cardID"
    
    func setCard(_ card:Card) {
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        
        self.card = card
        
        backImageView = UIImageView()
        frontImageView = UIImageView()
        
        backImageView.frame = contentView.bounds
        
        addSubview(frontImageView)
        addSubview(backImageView)
        
        frontImageView.translatesAutoresizingMaskIntoConstraints = true
        
        frontImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        frontImageView.image = UIImage(named:card.imageName)
        
        switch(level) {
        case 1:
            contentView.layer.borderColor = (UIColor(named: "lightYellow")?.cgColor as! CGColor)
            backImageView.image = UIImage(named: "cardFirstTour")
        case 2:
            contentView.layer.borderColor = (UIColor(named: "pink")?.cgColor as! CGColor)
            backImageView.image = UIImage(named: "cardSecondTour")
        case 3:
            contentView.layer.borderColor = (UIColor(named: "purple")?.cgColor as! CGColor)
            backImageView.image = UIImage(named: "cardThirdTour")
        default:
            contentView.layer.borderColor = (UIColor(named: "lightYellow")?.cgColor as! CGColor)
            backImageView.image = UIImage(named: "cardFirstTour")
        }
        
        
        
        if(card.isMatched == true)
        {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else{
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        if(card.isFlipped == true)
        {
              UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
        else{
             UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
        
        
        
    }
    
    func flipCard(){
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
    }
    
    func flipback()  {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
             UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
     
    }
    
    func remove() {
        
        backImageView.rotateCell()
        frontImageView.rotateCell()
        
        UIView.animate(withDuration: 0.8, delay: 0.8, options: .curveEaseOut, animations: {
            self.contentView.alpha = 0;
            self.frontImageView.alpha = 0;
            self.backImageView.alpha = 0;
        }, completion: nil)
       
    }
}

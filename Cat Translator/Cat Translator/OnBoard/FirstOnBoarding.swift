//
//  FirstOnBoarding.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 5.12.22.
//

import Foundation
import UIKit

class FirtstOnBoarding: UICollectionViewCell {

    public static var id = "first"
    
    let local = LocalizationVariables()

    lazy var label = Label(type: .boardingHeader, local.firstOnBoardingHeaderUp, local.firstOnBoardingHeaderDown)
    lazy var mainImage = ImageView(image: .boardingBig)
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundOnBoard")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //self.sendSubviewToBack(imageView)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirtstOnBoarding {
    
    func setup() {

        addSubview(imageView)
        addSubview(label)
        addSubview(mainImage)
       
        mainImage.image = UIImage(named: "onFirst")
        
        NSLayoutConstraint.activate([
            
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            mainImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            mainImage.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height/6.766),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height/2.333),
            
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIScreen.main.bounds.height/5.107),
            
            
        ])
    }
    
    
}

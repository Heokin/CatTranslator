//
//  ImageView.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//


import Foundation
import UIKit

class ImageView: UIImageView {
    
    enum TypeOfImage {
        case chevron
        case popUpImage
        case chevronRight
        case boardingBig
        case chevronLeft
        case setting
        case crown
        case star
        case mail
        case doc
        case secure
        case share
        case spokenText
        case elips
        case nothing
        case infinity
        case xmark
        case micro
        case changeIcon
        case refresh
        
        case score
    }
    
    init(image: TypeOfImage) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        switch image {
            
        case .popUpImage:
            self.image = UIImage(named: "popup")
            contentMode = .scaleAspectFill
        case .changeIcon:
            self.image = nil
            contentMode = .scaleAspectFit
        case .nothing:
            self.image = nil
        case .elips:
            self.image = UIImage(named: "elips")
            widthAnchor.constraint(equalToConstant: 24).isActive = true
            heightAnchor.constraint(equalToConstant: 24).isActive = true
        case .xmark:
            self.image = UIImage(named: "xmark")
            tintColor = UIColor(named: "grey")
            isUserInteractionEnabled = false
            widthAnchor.constraint(equalToConstant: 14).isActive = true
            heightAnchor.constraint(equalToConstant: 14).isActive = true
        case .micro:
            self.image = UIImage(named: "micro")
        case .chevron:
            self.image = UIImage(systemName: "chevron.right")
            tintColor = UIColor(named: "blue") ?? .systemBlue
            widthAnchor.constraint(equalToConstant: 15).isActive = true
            heightAnchor.constraint(equalToConstant: 15).isActive = true
        case .refresh:
            self.image = UIImage(systemName: "arrow.clockwise")
            tintColor = UIColor(named: "blue") ?? .systemBlue
            widthAnchor.constraint(equalToConstant: 18).isActive = true
            heightAnchor.constraint(equalToConstant: 20).isActive = true
        case .chevronRight:
            contentMode = .scaleAspectFit
            self.image = UIImage(named: "chevronRight")
            tintColor = UIColor(named: "grey") ?? .systemGray
            widthAnchor.constraint(equalToConstant: 6).isActive = true
            heightAnchor.constraint(equalToConstant: 12).isActive = true
        case .boardingBig:
            self.image = UIImage(named: "subImg")
            contentMode = .scaleAspectFit
        case .setting:
            self.image = UIImage(named: "gearshape.fill")
            widthAnchor.constraint(equalToConstant: 20).isActive = true
            heightAnchor.constraint(equalToConstant: 20).isActive = true
        case .chevronLeft:
            contentMode = .scaleAspectFill
            self.image = UIImage(systemName: "chevron.left")
            tintColor = UIColor(named: "grey") ?? .systemGray
            widthAnchor.constraint(equalToConstant: 20).isActive = true
            heightAnchor.constraint(equalToConstant: 24).isActive = true
        case .crown:
            self.image = UIImage(systemName: "crown")
            tintColor = .white
        case .star:
            self.image = UIImage(named: "star")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 18).isActive = true
            heightAnchor.constraint(equalToConstant: 17).isActive = true
        case .mail:
            self.image = UIImage(named: "envelope")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 18).isActive = true
            heightAnchor.constraint(equalToConstant: 14).isActive = true
        case .doc:
            self.image = UIImage(named: "doc.text")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 14).isActive = true
            heightAnchor.constraint(equalToConstant: 18).isActive = true
        case .secure:
            self.image = UIImage(named: "secure")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 14).isActive = true
            heightAnchor.constraint(equalToConstant: 18).isActive = true
        case .share:
            self.image = UIImage(named: "square.and.arrow.up")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 14).isActive = true
            heightAnchor.constraint(equalToConstant: 18).isActive = true
        case .spokenText:
            self.image = UIImage(systemName: "text.redaction")
            tintColor = .black
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 20.833).isActive = true
            heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 58).isActive = true
        case .infinity:
            self.image = UIImage(named: "infinity")
            tintColor = .white
            widthAnchor.constraint(equalToConstant: 26.75).isActive = true
            heightAnchor.constraint(equalToConstant: 12.35).isActive = true
            
        case .score:
            self.image = UIImage(named: "paw")
            tintColor = UIColor(named: "purple")
            widthAnchor.constraint(equalToConstant: 24).isActive = true
            heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {

    convenience init(color: UIColor, size: CGSize) {

        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        
        let context = UIGraphicsGetCurrentContext()!
        context.fill(CGRect(origin: .zero, size: size))
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(data: image.pngData()!)!
    }
}

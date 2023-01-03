//
//  DogCell.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 11.12.22.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class CatCell: UICollectionViewCell {
    
    public var image = ImageView(image: .changeIcon)
    public var text = Label(type: .semibold22, "", "")
    public var textStart = ""
    //public var viewFront = UIView()
    public var viewFront = UIImageView()
    public var access = false
    static let id = "catID"
    let yellow = ["No" , "Yummy", "Sleepy", "Froze", "Attention", "Lonely"]

    var animationView: LottieAnimationView = {
            var animation = LottieAnimationView()
            animation = .init(name: "stars")
            animation.animationSpeed = 0.6
            animation.loopMode = .loop
            animation.translatesAutoresizingMaskIntoConstraints = false
            animation.isUserInteractionEnabled = false
            return animation
        }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         setUp()
        
    }
    
    public func setup(image: String, text: String, access: Bool) {
        textStart = text
        self.text.text = NSLocalizedString("emotions" + textStart, comment: "")
        self.image.image = UIImage(named: image)
        self.viewFront.image = UIImage(named: "blur" + text)
        if access {
            self.image.isHidden = false
            self.text.isHidden = false
            viewFront.isHidden = true
            animationView.isHidden = true
            
        } else {
            viewFront.isHidden = false
            
            if yellow.contains(textStart) {
                animationView.isHidden = true
            } else {
                animationView.isHidden = false
                animationView.play()
            }
            
            self.image.isHidden = true
            self.text.isHidden = true
        }
        
        
        
    }
    
    func anim() {
        UIView.animate(withDuration: 1.0) {[weak self] in
            self?.image.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    func setUp() {
        
        contentView.layer.cornerRadius = 8
        
        addSubview(image)
        addSubview(text)
        viewFront.backgroundColor = .white

        addSubview(viewFront)
        addSubview(animationView)
        viewFront.bounds = bounds
        viewFront.translatesAutoresizingMaskIntoConstraints = false
        viewFront.isHidden = true
        animationView.isHidden = true
        text.textColor = .black
        
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalTo(text).offset(-5)
        }
        
        viewFront.snp.makeConstraints { make in
            make.left.bottom.top.right.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView{
    
    func rotate() {
        
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = NSNumber(value: -Double.pi + 2.5)
        rotation.toValue = NSNumber(value: 0.6)
        rotation.duration = 0.4
        rotation.autoreverses = true
        rotation.repeatCount = Float.infinity
        self.layer.add(rotation, forKey: "rotationAnimation")
        
        
        let delay : Double = 2.0    // 2 seconds here
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.layer.removeAllAnimations()
        }
    }
    
    func rotateLong() {
        
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = NSNumber(value: -Double.pi + 2.5)
        rotation.toValue = NSNumber(value: 0.6)
        rotation.duration = 0.4
        rotation.autoreverses = true
        rotation.repeatCount = Float.infinity
        self.layer.add(rotation, forKey: "rotationAnimation")
        
        
        let delay : Double = 4.0    // 2 seconds here
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.layer.removeAllAnimations()
        }
    }
    
    func rotateCell() {
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = NSNumber(value: -0.1)
        rotation.toValue = NSNumber(value: 0.1)
        rotation.duration = 0.4
        rotation.autoreverses = true
        rotation.repeatCount = Float.infinity
        self.layer.add(rotation, forKey: "rotationAnimation")
        
        let delay : Double = 1.0    // 2 seconds here
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.layer.removeAllAnimations()
        }
    
    }
}

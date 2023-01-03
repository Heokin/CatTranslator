//
//  View.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit

class View: UIView {
    
    enum ViewType {
        case border
        case subscribeSubView
        case subscribeSubViewPlace
        case navigationView
        case dismissView
        case subscribeView
        
        case disperse
        case settingView
        case ads
        case roundedView
        
    }
    
    init(type: ViewType) {
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
            
        case .border:
            layer.cornerRadius = 8
            layer.borderWidth = 2
            layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        case .subscribeView:
            backgroundColor = UIColor(red: 0.51, green: 0.78, blue: 0.902, alpha: 1)
            layer.cornerRadius = 12
        case .navigationView:
            backgroundColor = .clear
        case .roundedView:
            widthAnchor.constraint(equalToConstant: 32).isActive = true
            heightAnchor.constraint(equalToConstant: 32).isActive = true
            layer.cornerRadius = 16
        case .ads:
            backgroundColor = .clear
            leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        case .subscribeSubView:
            backgroundColor = .white
            layer.cornerRadius = 20
            layer.borderWidth = 2
            layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        case .subscribeSubViewPlace:
            backgroundColor = UIColor(named: "pink")
            layer.cornerRadius = 20
            layer.borderWidth = 2
            layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .dismissView:
            heightAnchor.constraint(equalToConstant: 40).isActive = true
        case .disperse:
            backgroundColor = UIColor(red: 0.855, green: 0.518, blue: 0.2, alpha: 0.15)
            layer.borderWidth = 0.5
            layer.borderColor = UIColor(named: "orange")?.cgColor
        case .settingView:
            backgroundColor = UIColor(named: "orange")
            widthAnchor.constraint(equalToConstant: 30).isActive = true
            heightAnchor.constraint(equalToConstant: 30).isActive = true
            layer.cornerRadius = 7
            layer.masksToBounds = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {

    func removeConstraints() { removeConstraints(constraints) }
    func deactivateAllConstraints() { NSLayoutConstraint.deactivate(getAllConstraints()) }
    func getAllSubviews() -> [UIView] { return UIView.getAllSubviews(view: self) }

    func getAllConstraints() -> [NSLayoutConstraint] {
        var subviewsConstraints = getAllSubviews().flatMap { $0.constraints }
        if let superview = self.superview {
            subviewsConstraints += superview.constraints.compactMap { (constraint) -> NSLayoutConstraint? in
                if let view = constraint.firstItem as? UIView, view == self { return constraint }
                return nil
            }
        }
        return subviewsConstraints + constraints
    }

    class func getAllSubviews(view: UIView) -> [UIView] {
        return view.subviews.flatMap { [$0] + getAllSubviews(view: $0) }
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}

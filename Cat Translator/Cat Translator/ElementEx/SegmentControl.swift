//
//  SegmentControl.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 6.12.22.
//

import Foundation
import UIKit

class SegmentControl: UISegmentedControl {
    
    private var segmentInset: CGFloat = 0.1{
            didSet{
                if segmentInset == 0{
                    segmentInset = 0.1
                }
            }
        }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
        
        
    }
    
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
        super.init (coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true
        self.layer.shadowOpacity = 0.0
        backgroundColor = .clear
        
        let selectedImageViewIndex = numberOfSegments
        
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {

            if selectedImageViewIndex == 2 {
                selectedImageView.backgroundColor = UIColor(named: "blue")
            }
            
            selectedImageView.image = nil
            
            //MARK: - Configure selectedImageView Inset with SegmentControl
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
                        
                        //MARK: - Configure selectedImageView cornerRadius
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = 35
            selectedImageView.bounds = CGRect(x: selectedImageView.bounds.minX+10, y: selectedImageView.bounds.minY+10, width: selectedImageView.bounds.width-20, height: selectedImageView.bounds.height-20)
                        
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }

    }
    
}

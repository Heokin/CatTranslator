//
//  Collection.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 5.12.22.
//

import Foundation
import UIKit

class Collection: UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    
    func setupLayout() {
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
    }
    
    init(delegate: UICollectionViewDelegateFlowLayout, dataSource: UICollectionViewDataSource) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupLayout()
        
        self.delegate = delegate
        self.dataSource = dataSource
    
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

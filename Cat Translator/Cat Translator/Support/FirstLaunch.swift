//
//  FirstLaunch.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation

class IsFirstLaunch {
    static let shared = IsFirstLaunch()
    
    var isFirstLaunch: Bool {
        get {
            UserDefaults.standard.bool(forKey: #function)
        } set  {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}

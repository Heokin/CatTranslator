//
//  Card.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import Foundation

class CardModel{
    
    var genearatedCardArray = [Card]()

    func getCard() -> [Card] {
    
        for i in 1...10 {
            
            let card = Card()
            card.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card)
            
            let card2 = Card()
            card2.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card2)
        }
    
        return genearatedCardArray;
    }
    
    func getCardSecond() -> [Card] {
    
        for i in 11...20 {
            
            let card = Card()
            card.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card)
            
            let card2 = Card()
            card2.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card2)
        }
    
        return genearatedCardArray;
    }
    
    func getCardThird() -> [Card] {
    
        for i in 21...30 {
            
            let card = Card()
            card.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card)
            
            let card2 = Card()
            card2.imageName = "kitty\(i)"
            
            genearatedCardArray.append(card2)
        }
    
        return genearatedCardArray;
    }
}

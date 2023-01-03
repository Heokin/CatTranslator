//
//  NewGameLogic.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 22.12.22.
//

import Foundation
import UIKit
import SnapKit
import AVFAudio

extension NewGameController {
    
    func setUpLogic() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 9
    
        layout.itemSize = CGSize(width: cellWidth-2, height: cellHeight)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        guard let collection = collectionView else { return }
        
        collection.backgroundColor = .clear

        collection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.id)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.equalTo(scoreImage.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(UIScreen.main.bounds.width/25)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
    @objc func handleClose(paramSander: Any){
        
        let vc = TranslatorController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func handleRefresh(){
        
        cardArray = []
        collectionView.reloadData()
        print(cardArray.count)
        cardArray = cardModel.getCard()
        cardArray.shuffle()
        level = 1
        UserDefaults.standard.set(1, forKey: "Level")
        reloadFlag = 20
        
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func checkGameEnded()
    {
        counter += 1
        if counter == 10 {
            let delay : Double = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let vc = LevelController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
                self.counter = 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.id, for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        if reloadFlag != 0 {
            cell.alpha = 1;
            cell.frontImageView.alpha = 1;
            cell.backImageView.alpha = 1;
            cell.flipback()
            reloadFlag -= 1
        }
        
        cell.flipCard()
        let delay : Double = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            cell.flipback()
        }
        
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

        let card = cardArray[indexPath.row]
        if card.isFlipped == false && card.isMatched == false {
            card.isFlipped = true
            cell.flipCard()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            
            //SoundManager.playSound(.flip)
            
            playSound(name: "open")
            print(player?.volume)
            
            if firstIndexFlippedPathIndex == nil {
                firstIndexFlippedPathIndex = indexPath
            }
            else{
                checkForMatchs(indexPath)
            }
        }
    }
    
    func checkForMatchs(_ secondFlippedCardIndexIndexPath :IndexPath) {
        
        
        let fistIndexCell = collectionView.cellForItem(at: firstIndexFlippedPathIndex!) as? CardCollectionViewCell
        
        let secondIndexCell = collectionView.cellForItem(at: secondFlippedCardIndexIndexPath) as? CardCollectionViewCell
        
        let firstFliipedIndexCard  = cardArray[firstIndexFlippedPathIndex!.row]
        let secondFlippedIndexCard = cardArray[secondFlippedCardIndexIndexPath.row]
        
        if firstFliipedIndexCard.imageName == secondFlippedIndexCard.imageName
        {
            firstFliipedIndexCard.isMatched = true
            secondFlippedIndexCard.isMatched = true
            fistIndexCell?.remove()
            secondIndexCell?.remove()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            
            playSound(name: "match")
            //print(player?.volume)
            //SoundManager.playSound(.match)
            
            supportUD = UserDefaults.standard.value(forKey: "score") as? String ?? "0"
            let helper = Int(supportUD)! + 1
            supportUD = String(helper)
            UserDefaults.standard.set(supportUD, forKey: "score")
            scoreLabel.text = String(supportUD)
            
            scoreLabel.rotateCell()
            
            checkGameEnded()
        }
        else{
            fistIndexCell?.flipback()
            secondIndexCell?.flipback()
            firstFliipedIndexCard.isFlipped = false
            secondFlippedIndexCard.isFlipped = false;
            
            //SoundManager.playSound(.noMatch)
            
        }
        if fistIndexCell == nil {
            collectionView.reloadItems(at: [firstIndexFlippedPathIndex!])
        }
        firstIndexFlippedPathIndex = nil
    }
    
    func playSound(name: String) {
                guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
                let url = URL(fileURLWithPath: path)

                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.prepareToPlay()
                    player?.play()
                    player?.volume = 1.0
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch(let error) {
                    print(error.localizedDescription)
            }
        }
    
}

extension NewGameController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSizeMake(cellWidth-2, cellHeight)

      }
    
}


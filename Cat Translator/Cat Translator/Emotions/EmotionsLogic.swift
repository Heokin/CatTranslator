//
//  EmotionsLogic.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import SnapKit
import AVFAudio
import GoogleMobileAds

extension EmotionsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        collection!.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.id, for: indexPath) as! CatCell
        
        var access = false
        if UserDefaults.standard.value(forKey: catIconArray[indexPath.row].text) as? String == "0" &&
            UserDefaults.standard.value(forKey: "FullAccess") as? Int != 1 {
            access = false
        } else {
            access = true
        }
        
        cell.setup(image: catIconArray[indexPath.row].image, text: catIconArray[indexPath.row].text, access: access)
        
        if textLow.contains(cell.textStart) {
            cell.text.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-12)
            }
        } else {
            cell.text.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-24)
            }
        }
        
        if blue.contains(cell.textStart) {
            cell.image.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(50)
                make.top.equalToSuperview().offset(30)
                make.bottom.equalToSuperview().offset(-70)
            }
        } else if oneOne.contains(cell.textStart) {
            cell.image.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(23)
                make.top.equalToSuperview().offset(11)
                make.bottom.equalToSuperview().offset(-39)
            }
        } else if twoOne.contains(cell.textStart) {
            cell.image.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(23)
                make.top.equalToSuperview().offset(58)
                make.bottom.equalToSuperview().offset(-100)
            }
        } else {
            cell.image.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(80)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-38)
            }
        }

        if selectedIndex == indexPath && access == true {
            
            if blue.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "blue")
            } else if yellow.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "lightYellow")
            } else if purple.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "purple")
            } else {
                cell.contentView.backgroundColor = UIColor(named: "pink")
            }
            
            var delay = 2.0
            
            if longSound.contains(cell.textStart) {
                cell.image.rotateLong()
                delay = 4.0
            } else {
                cell.image.rotate()
            }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            
            if player == nil {
                playSound(name: cell.textStart)
            } else {
                player?.stop()
                player = nil
                playSound(name: cell.textStart)
            }
            
            print(player?.volume)
            
            self.selectedIndex = [0, 99]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                cell.contentView.backgroundColor = cell.contentView.backgroundColor!.withAlphaComponent(0.7)

            }
           
            
        } else if selectedIndex == indexPath && access != true{
            if oController as? String == "1" {
                let vc = FirstSubscribeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else if oController as? String == "0" {
                
            }
            else {
                let vc = SecondSubscribeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            selectedIndex = [0, 99]
        } else {
            if blue.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.7)
            } else if yellow.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "lightYellow")?.withAlphaComponent(0.7)
            } else if purple.contains(cell.textStart) {
                cell.contentView.backgroundColor = UIColor(named: "purple")?.withAlphaComponent(0.7)
            } else {
                cell.contentView.backgroundColor = UIColor(named: "pink")?.withAlphaComponent(0.7)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.id, for: indexPath) as! CatCell
        
//        var access = false
//        if UserDefaults.standard.value(forKey: catIconArray[indexPath.row].text) as? String == "0" &&
//            UserDefaults.standard.value(forKey: "FullAccess") as? Int != 1 {
//            access = false
//            //access = true
//        } else {
//            access = true
//        }
        
        
        selectedIndex = indexPath
        
//        if cell.viewFront.isHidden {
//            if oController as? String == "1" {
//                let vc = FirstSubscribeViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            } else if oController as? String == "0" {
//
//            }
//            else {
//                let vc = SecondSubscribeViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }
//            let vc = PopUpBoard()
//            vc.image = cell.image.image
//            vc.textFree = cell.textStart
//            if blue.contains(cell.textStart) {
//                vc.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.7)
//            } else if yellow.contains(cell.textStart) {
//                vc.backgroundColor = UIColor(named: "lightYellow")?.withAlphaComponent(0.7)
//            } else if purple.contains(cell.textStart) {
//                vc.backgroundColor = UIColor(named: "purple")?.withAlphaComponent(0.7)
//            } else {
//                vc.backgroundColor = UIColor(named: "pink")?.withAlphaComponent(0.7)
//            }
//            vc.modalPresentationStyle = .overFullScreen
//            present(vc, animated: false)
        //}
        collectionView.reloadData()
        
    }
    
    @objc func setting() {
        let vc = SettingViewController()
        self.present(vc, animated: true)
    }
    
    @objc func handleClose(paramSander: Any){
        dismiss(animated: true, completion: nil)
    }
    
    
    func setUpLogic() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UIScreen.main.bounds.width / 46.875
        layout.minimumInteritemSpacing = UIScreen.main.bounds.width / 46.875

        collection = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        guard let collection = collection else { return }
        
        collection.backgroundColor = .clear

        collection.register(CatCell.self, forCellWithReuseIdentifier: CatCell.id)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(76)
            make.left.right.equalTo(view).inset(UIScreen.main.bounds.width/25)
            make.bottom.equalTo(view).offset(0)
        }
    }
    
//    func loadRewardedAd() {
//        let request = GADRequest()
//        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
//                           request: request,
//                           completionHandler: { [self] ad, error in
//          if let error = error {
//            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
//            return
//          }
//          rewardedAd = ad
//          print("Rewarded ad loaded.")
//          //rewardedAd?.fullScreenContentDelegate = self
//        }
//        )
//      }

}

extension EmotionsController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width : CGFloat
        let height : CGFloat
        
        let w = UIScreen.main.bounds.width - UIScreen.main.bounds.width / 9.6


                if indexPath.item == 0  || indexPath.item == 5 || indexPath.item == 10 || indexPath.item == 14 || indexPath.item == 18 {
                    width = w / 3 * 2
                    height = w / 3 * 2
                } else if indexPath.item == 1 || indexPath.item == 4 || indexPath.item == 11 || indexPath.item == 15 || indexPath.item == 19{
                    width = w / 3
                    height = w / 3 * 2
                } else if indexPath.item == 3 || indexPath.item == 6 || indexPath.item == 9 || indexPath.item == 13 || indexPath.item == 17 {
                    width = w / 3 * 2
                    height = w / 3
                } else {
                    width = w / 3
                    height = w / 3
                }
                return CGSizeMake(width, height)
        
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


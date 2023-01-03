//
//  SettingController.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    let local = LocalizationVariables()
    var  value = "0"
    var rateUs = "0"
    var oController = UserDefaults.standard.value(forKey: "oController")

    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        if UIScreen.main.bounds.width > 500 {
            imageView.image = UIImage(named: "backgroundMainIPad")
        } else {
            imageView.image = UIImage(named: "backgroundMain")
        }
            
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var subView = View(type: .subscribeView)
    lazy var subImage = ImageView(image: .crown)
    lazy var subLabel = Label(type: .subLabel, local.unlockButton, "")
    lazy var subTap = UITapGestureRecognizer(target: self, action: #selector(sub))
    
    lazy var tabbleView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        
        tb.backgroundColor = .clear
        
        return tb
    }()
    
    lazy var done = Button(type: .doneButton, local.buttonDone)
    
    lazy var header = Label(type: .pageTitle, local.titleSetting, "")
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        tabbleView.reloadData()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
        
        setup()
    }
    

}

extension SettingViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}

//
//  TableViewEx.swift
//  Cat Translator
//
//  Created by Kirill Sedliarov on 4.12.22.
//

import Foundation
import UIKit
import MessageUI

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = SettingCell(
            reuseID: "cell",
            icon: ImageView(image: .chevron),
            label: Label(type: .mainText, "", ""),
            color: UIColor(named: "black")!,
            chevron: ImageView(image: .chevronRight)
        )
        cell.backgroundColor = .clear
        
        
            switch indexPath.row {
                case 0:
                    cell = SettingCell(
                       reuseID: "cell",
                       icon: ImageView(image: .star),
                       label: Label(type: .mainText, local.settingRateUs, ""),
                       color: UIColor(named: "blue")!,
                       chevron: ImageView(image: .chevronRight)
                       
                   )
                    cell.backgroundColor = .clear
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 0)

                case 1:
                    cell = SettingCell(
                       reuseID: "cell",
                       icon: ImageView(image: .mail),
                       label: Label(type: .mainText, local.settingSupport, ""),
                       color: UIColor(named: "purple")!,
                       chevron: ImageView(image: .chevronRight)
                   )
                    cell.backgroundColor = .clear
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 0)
                  
                case 2:
                    cell = SettingCell(
                       reuseID: "cell",
                       icon: ImageView(image: .secure),
                       label: Label(type: .mainText, local.settingPrivacyPolicy, ""),
                       color: UIColor(red: 0.471, green: 0.812, blue: 0.753, alpha: 1),
                       chevron: ImageView(image: .chevronRight)
                   )
                    cell.backgroundColor = .clear
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 0)
                    
                case 3:
                    cell = SettingCell(
                       reuseID: "cell",
                       icon: ImageView(image: .doc),
                       label: Label(type: .mainText, local.settingTermsOfUse, ""),
                       color: UIColor(named: "pink")!,
                       chevron: ImageView(image: .chevronRight)
                   )
                    cell.backgroundColor = .clear
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 0)
                    
                case 4:
                    cell = SettingCell(
                       reuseID: "cell",
                       icon: ImageView(image: .share),
                       label: Label(type: .mainText, local.settingShareTheApp, ""),
                       color: UIColor(red: 1, green: 0.749, blue: 0.616, alpha: 1),
                       chevron: ImageView(image: .chevronRight)
                   )
        
                    cell.backgroundColor = .clear
                    cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
                default:
                    break
                }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            switch indexPath.row {
            case 0:
                rate()
            case 1:
                support()
                
            case 2:
                if let url = URL(string: "https://www.mindateq.io/privacy-policy") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case 3:
                if let url = URL(string: "https://www.mindateq.io/terms-of-use") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case 4: shareAs()
            default:
                break
            }
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func rate() {
        
        
        self.rateUs = UserDefaults.standard.value(forKey: "rateUs") as? String ?? "0"
        
        if !Reachability.isConnectedToNetwork() {
            rateUs = "0"
        }
            
            if Int(rateUs)! == 1 {
                
                let alert = UIAlertController(title: local.alertRate,
                                              message: "",
                                              preferredStyle: .alert)
                
                alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
                
                let cancelAlertButton = UIAlertAction(title: local.alertNo, style: .default) {
                    [self] UIAlertAction in
                    support()
                }
                
                let saveAlertButton = UIAlertAction(title: local.alertYes, style: .default) { _ in
                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id1658791988"),
                       UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.open(url)
                    }
                }
                
                alert.addAction(cancelAlertButton)
                alert.addAction(saveAlertButton)
                
                present(alert, animated: true)
            } else {
                DispatchQueue.main.async {
                    let productURL = URL(string:  "itms-apps://itunes.apple.com/app/id1658791988")
                    var components = URLComponents(url: productURL!, resolvingAgainstBaseURL: false)
                    components?.queryItems = [
                      URLQueryItem(name: "action", value: "write-review")
                    ]
                    guard let writeReviewURL = components?.url else {
                      return
                    }
                    UIApplication.shared.open(writeReviewURL)
                }
                
            }
        
    }
    
    func support() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.overrideUserInterfaceStyle = .light
            mail.mailComposeDelegate = self
            let systemVersion = UIDevice.current.systemVersion
            let devicename = UIDevice.modelName
            let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

            mail.setToRecipients(["support@mindateq.io"])
            mail.setSubject("Cat Translator — User Question ")
            mail.setMessageBody("<p></p><p>----------------</p><p> Device: \(devicename)</p><p>iOS: \(systemVersion)</p><p>App version: \(appVersion!) (\(buildNumber))</p>", isHTML: true)
            present(mail, animated: true)
        } else { }
    }
    
    private func shareAs() {
        var textToShare = local.sharing
        textToShare += "https://apps.apple.com/app/id1658791988"
        
            let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            if let popoverController = activityVC.popoverPresentationController {
                    popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                    popoverController.sourceView = self.view
                    popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                }

            self.present(activityVC, animated: true, completion: nil)
    }
    

    
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension UIAlertController {

    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }

        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }

    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }

        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }

    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
    
    
}


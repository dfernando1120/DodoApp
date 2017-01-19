//
//  SettingsViewController.swift
//  Dodo
//
//  Created by Dillon Fernando on 4/27/16.
//  Copyright © 2016 Klubhouse. All rights reserved.
//

// NOTE: THIS IS NOT THE ACTUAL APP. IT'S JUST A SKELETON THAT SHOWS MOST OF THE FEATURES AND FUNCTIONALITY. SEE BELOW FOR THE LINKS TO THE APP STORE, WEBSITE AND FACEBOOK SITE

// ITUNES STORE: https://itunes.apple.com/us/app/dodo-lame-jokes/id1111749649?mt=8
// WEBSITE: https://thedodoapp.com
// FACEBOOK: https://www.facebook.com/dodolamejokes/


import UIKit
import MessageUI


class SettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate, SettingsDetailViewControllerDelegate {
    
    //MODEL CLASS
    let audio = Audio()
    
    //NOTIFICATION CENTER
    let notificationCenter = NotificationCenter.default
    
    //URL OPEN OPTIONS
    let options = [UIApplicationOpenURLOptionUniversalLinksOnly : true]

    
    

    
    // MARK: VIEW LOAD/SETUP METHODS --------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        notificationCenter.addObserver(self, selector:#selector(SettingsViewController.applicationEnteredBackgroundFromSettings), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    
    
    
    
    // MARK: APPLICATION ENTERED BACKGROUND METHOD -------------------------------------------------------------------
    
    func applicationEnteredBackgroundFromSettings() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func dismissSettingsViewControllers() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    // MARK: CANCEL SETTINGS METHOD -------------------------------------------------------------------------------------
    
    @IBAction func cancelSettings(_ sender: UIBarButtonItem) {
        audio.buttonClick()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    // MARK: TABLEVIEW METHOD -------------------------------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audio.buttonClick()
        
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0 {
            let alertController = UIAlertController(title: "Notifications", message: "Notifications can be enabled or disabled in settings.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (alertAction) -> Void in
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(appSettings, options: self.options, completionHandler: nil)
                }
            })
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
            
        else if (indexPath as NSIndexPath).section == 1 && (indexPath as NSIndexPath).row == 0 {
            let urlStr = "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=1111749649" //OPEN APP REVIEW TAB IN ITUNES
            UIApplication.shared.open(URL(string: urlStr)!, options: self.options, completionHandler: nil)
        }
            
        else if (indexPath as NSIndexPath).section == 3 && (indexPath as NSIndexPath).row == 0 {
            if MFMailComposeViewController.canSendMail() {
                let composer = MFMailComposeViewController()
                composer.mailComposeDelegate = self
                composer.setToRecipients(["info@thedodoapp.com"])
                present(composer, animated: true, completion: nil)
            } else {
                print("No email account found.")
            }
        }
        
        else if (indexPath as NSIndexPath).section == 4 && (indexPath as NSIndexPath).row == 0 {
            if let facebookLink = URL(string: "https://www.facebook.com/thedodolamejokes/"){
                UIApplication.shared.open(facebookLink, options: self.options, completionHandler: nil)
            }
        }
    
        else if (indexPath as NSIndexPath).section == 5 && (indexPath as NSIndexPath).row == 0 {
            if let websiteLink = URL(string: "http://thedodoapp.com"){
                UIApplication.shared.open(websiteLink, options: self.options, completionHandler: nil)
            }
        }
    }
    
    
    
    
    
    // MARK: MAIL COMPOSER METHOD ---------------------------------------------------------------------------
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: SEGUE METHOD -------------------------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SettingsDetailViewController
        destinationVC.delegate = self
        
        if segue.identifier == "FAQ" {
            destinationVC.settingsSegue = "FAQ"
            destinationVC.textForTextView = "The content found within this application is meant solely for the purpose of entertainment. We understand that some material may be found offensive, and therefore, we must advise that you browse at your own risk. Please understand that the content of the application does not correspond to any of the views held by Klubhouse Technologies LLC or its members." + "\n" + "\n" + "Furthermore, it should be known that the content found within the application is not owned by Klubhouse Technologies LLC. The material has been gathered over time through multiple resources and outlets. We firmly believe that the content is not subject to copyright. However, if a company or individual possesses a claim as the creator or owner of any material, please contact us and it will be removed swiftly."
        }
    }
}

//
//  Sharing.swift
//  Dodo
//
//  Created by Dillon Fernando on 4/26/16.
//  Copyright © 2016 Klubhouse. All rights reserved.
//

// NOTE: THIS IS NOT THE ACTUAL APP. IT'S JUST A SKELETON THAT SHOWS MOST OF THE FEATURES AND FUNCTIONALITY. SEE BELOW FOR THE LINKS TO THE APP STORE, WEBSITE AND FACEBOOK SITE

// ITUNES STORE: https://itunes.apple.com/us/app/dodo-lame-jokes/id1111749649?mt=8
// WEBSITE: https://thedodoapp.com
// FACEBOOK: https://www.facebook.com/dodolamejokes/


import Foundation
import Social
import MessageUI


class Sharing: NSObject, MFMessageComposeViewControllerDelegate {

    //URL OPEN OPTIONS
    let options = [UIApplicationOpenURLOptionUniversalLinksOnly : true]

    func twitterAction(_ view: UIViewController, joke: String) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetComposer?.setInitialText(joke)
            view.present(tweetComposer!, animated: true, completion: nil)
            
        } else {
            //TWITTER SETTINGS
            let alertController = UIAlertController(title: "Twitter Unavailable", message: "Looks like you haven't registered your Twitter account. Please login in settings to continue.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (alertAction) -> Void in
                UIApplication.shared.open(URL(string:"prefs:root=TWITTER")!, options: self.options, completionHandler: nil)
            })
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            view.present(alertController, animated: true, completion: nil)
        }
    }
    
    func facebookAction(_ view: UIViewController, joke: String){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookComposer?.setInitialText(joke)
            view.present(facebookComposer!, animated: true, completion: nil)
            
        } else {
            //FACEBOOK SETTINGS
            let alertController = UIAlertController(title: "Facebook Unavailable", message: "Looks like you haven't registered your Facebook account. Please login in settings to continue.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (alertAction) -> Void in
                UIApplication.shared.open(URL(string:"prefs:root=FACEBOOK")!, options: self.options, completionHandler: nil)
            })
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            view.present(alertController, animated: true, completion: nil)
        }
    }
    
    func sendText(_ view: UIViewController, joke:String) {
        if !self.canSendText() {
            let alertMessage = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable of sending text messages.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            view.present(alertMessage, animated: true, completion: nil)
            return
        } else {
            let messageController = configuredMessageComposeViewController(joke)
            view.present(messageController, animated: true, completion: nil)
        }
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func configuredMessageComposeViewController(_ joke: String) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.body = joke
        return messageComposeVC
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

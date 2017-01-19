//
//  SettingsDetailViewController.swift
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


protocol SettingsDetailViewControllerDelegate {
    func dismissSettingsViewControllers ()
}

class SettingsDetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    //MODEL CLASSES
    let audio = Audio()
    
    //DATA VARIABLES
    var settingsSegue: String?
    var textForTextView: String?
    
    //NOTIFICATION CENTER
    let notificationCenter = NotificationCenter.default
    
    //DELEGATE
    var delegate: SettingsDetailViewControllerDelegate?
    
  
    
    
    
    // MARK: VIEW LOAD/SETUP METHODS ---------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        if settingsSegue == "FAQ" {
            navigationItem.title = "FAQ"
            textView.text = textForTextView
        }
        
        notificationCenter.addObserver(self, selector:#selector(SettingsDetailViewController.applicationEnteredBackgroundFromSettingsDetail), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    
    
    
    
    // MARK: APPLICATION ENTERED BACKGROUND METHOD ---------------------------------------------------------------------
    
    func applicationEnteredBackgroundFromSettingsDetail() {
        _ = navigationController?.popViewController(animated: true)
        delegate?.dismissSettingsViewControllers()
    }
    
    
    
    
    
    // MARK: CANCEL SETTINGS METHOD -------------------------------------------------------------------------------------
    
    @IBAction func backToSettings(_ sender: UIBarButtonItem) {
        audio.buttonClick()
        _ = navigationController?.popViewController(animated: true)
    }
}

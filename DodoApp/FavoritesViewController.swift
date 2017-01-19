//
//  FavoritesViewController.swift
//  Dodo
//
//  Created by Dillon Fernando on 4/26/16.
//  Copyright © 2016 Klubhouse. All rights reserved.
//

// NOTE: THIS IS NOT THE ACTUAL APP. IT'S JUST A SKELETON THAT SHOWS MOST OF THE FEATURES AND FUNCTIONALITY. SEE BELOW FOR THE LINKS TO THE APP STORE, WEBSITE AND FACEBOOK SITE

// ITUNES STORE: https://itunes.apple.com/us/app/dodo-lame-jokes/id1111749649?mt=8
// WEBSITE: https://thedodoapp.com
// FACEBOOK: https://www.facebook.com/dodolamejokes/


import UIKit
import Social
import MessageUI


protocol FavoritesViewControllerDelegate {
    func deleteJokeFromFavoritesArray (_ index: Int)
}

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var modalCardView: UIView!
    
    //MODEL CLASSES
    let design = Design()
    let sharing = Sharing()
    let audio = Audio()
    
    //COLOR INTEGER
    var colorInt: UIColor?
    
    //DATA
    var favoritesJokesArray = [FavoriteJokes]()
    
    //DELEGATE
    var delegate: FavoritesViewControllerDelegate?
    
    //NOTIFICATION CENTER
    let notificationCenter = NotificationCenter.default
    
    
    
    
    
    // MARK: VIEW LOAD/SETUP METHODS -----------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalCardView.backgroundColor = colorInt
        design.jokeCardShadow(modalCardView)
        notificationCenter.addObserver(self, selector:#selector(FavoritesViewController.applicationEnteredBackgroundFromFavorites), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    
    
    
    // MARK: APPLICATION ENTERED BACKGROUND METHOD -----------------------------------------------------------------
    
    func applicationEnteredBackgroundFromFavorites() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: TABLEVIEW METHODS ---------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(favoritesJokesArray[(indexPath as NSIndexPath).row].joke)\n"
        cell.detailTextLabel?.text = favoritesJokesArray[(indexPath as NSIndexPath).row].answer
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesJokesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audio.buttonClick()
        let joke = self.favoritesJokesArray[(indexPath as NSIndexPath).row].joke
        let shareMenu = UIAlertController(title: nil, message: "Share", preferredStyle: .alert)
        
        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: {
            Void in
            self.sharing.twitterAction(self, joke: joke)
        })
        let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default, handler: {
            Void in
            self.sharing.facebookAction(self, joke: joke)
        })
        let smsAction = UIAlertAction(title: "SMS Message", style: UIAlertActionStyle.default, handler: {
            Void in
            self.sharing.sendText(self, joke: joke)
        })
        let deleteAction = UIAlertAction(title: "Delete From Favorites", style: UIAlertActionStyle.default, handler: {
            Void in
            self.favoritesJokesArray.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.delegate?.deleteJokeFromFavoritesArray((indexPath as NSIndexPath).row)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(smsAction)
        shareMenu.addAction(deleteAction)
        shareMenu.addAction(cancelAction)
        self.present(shareMenu, animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: CLOSE FAVORITES MODAL METHOD -------------------------------------------------------------------
    
    @IBAction func closeFavoritesModal(_ sender: UIButton) {
        audio.buttonClick()
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  DodoViewController.swift
//  Dodo
//
//  Created by Dillon Fernando on 4/25/16.
//  Copyright © 2016 Klubhouse. All rights reserved.
//

// NOTE: THIS IS NOT THE ACTUAL APP. IT'S JUST A SKELETON THAT SHOWS MOST OF THE FEATURES AND FUNCTIONALITY. SEE BELOW FOR THE LINKS TO THE APP STORE, WEBSITE AND FACEBOOK SITE

// ITUNES STORE: https://itunes.apple.com/us/app/dodo-lame-jokes/id1111749649?mt=8
// WEBSITE: https://thedodoapp.com
// FACEBOOK: https://www.facebook.com/dodolamejokes/


import UIKit
import AVFoundation


class DodoViewController: UIViewController, FavoritesViewControllerDelegate {
    
    @IBOutlet weak var jokeCardView: UIView!
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var addFavsButton: UIButton!
    @IBOutlet weak var faceButton: UIButton!
    @IBOutlet weak var favsButton: UIButton!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var shareMenuButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    //MODEL CLASSES
    let randomDigit = RandomDigit()
    let animations = Animations()
    let audio = Audio()
    let design = Design()
    let sharing = Sharing()
    
    //FAVORITE JOKES ARRAY
    var favoriteJokes = [FavoriteJokes]()
    
    //JOKE VARIABLE
    var jokeIndex = 0
    
    //COLORS
    var colors = [UIColor]()
    var backgroundImageArray = [UIImage]()
    var colorIndex: Int?
    
    //SOUNDS
    var swooshSound: AVAudioPlayer?
    var boingSound: AVAudioPlayer?
    var jokeSound: AVAudioPlayer?
    
    //GESTURE VARIABLES
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var gravityBehavior: UIGravityBehavior!
    var snapBehavior: UISnapBehavior!
    
    //PERSISTENCE
    var saveFile: URL?
    
    //NOTIFICATION VARIABLE
    let notificationCenter = NotificationCenter.default
    
    //JOKE CARD HEIGHT
    @IBOutlet weak var jokeCardHeight: NSLayoutConstraint!
    @IBOutlet weak var iconHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var faceButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var faceButtonHeight: NSLayoutConstraint!
    
    //WALKTHROUGH ELEMENTS
    @IBOutlet weak var walkthroughView: UIView!
    @IBOutlet weak var walkthroughLabel: UILabel!
    @IBOutlet weak var walkthroughViewHeight: NSLayoutConstraint!
    @IBOutlet weak var walkthroughViewTopConstraint: NSLayoutConstraint!
    
    //FACES
    var showAnswer: Bool = true     //THIS VARIABLE PERMITS THE ANSWER TO BE SHOWN WHEN THE TEXT LABEL SHOWS THE JOKE QUESTION
    var faceIndex: Int?
    var faceImageArray = [UIImage]()
    
    //USER DEFAULTS
    let defaults = UserDefaults.standard
    
    
    
    
    
    // MARK: A. SMALL ARRAY OF JOKES -------------------------------------------------------------------------
    
    //NOTE: This is dummy data for viewing purposes only. Actual data is stored on CloudKit.

    var jokesArray:[Jokes] = [
        Jokes(joke: "What did Jay-Z call Beyonce before they got married?", answer: "Feyonce.", icon: "ICONS-A-4.png"),
        Jokes(joke: "Why do seagulls fly over the sea?", answer: "Because if they flew over the bay, they'd be called bagels.", icon: "ICONS-A-22.png"),
        Jokes(joke: "What kind of concert only costs 45 cents?", answer: "50 cent featuring Nickelback.", icon: "ICONS-A-23.png"),
        Jokes(joke: "What happens to illegally parked frogs?", answer: "They get toad away.", icon: "ICONS-A-7.png"),
        Jokes(joke: "What does a clock do when it's still hungry?", answer: "It goes back four seconds.", icon: "ICONS-A-27.png"),
        Jokes(joke: "What kind of lettuce do they serve on the titanic?", answer: "Iceberg.", icon: "ICONS-A-9.png"),
        Jokes(joke: "What do you call a fake pasta?", answer: "An impasta.", icon: "ICONS-A-12.png"),
        Jokes(joke: "Why does Snoop Dogg carry an umbrella?", answer: "Fo Drizzle.", icon: "ICONS-A-16.png"),
        Jokes(joke: "What do you call cheese that’s not yours?", answer: "NACHO CHEESE!", icon: "ICONS-A-17.png"),
        Jokes(joke: "Wanna hear a pizza joke?", answer: "Nevermind, it's too cheesy.", icon: "ICONS-A-18.png")
    ]
    
  
    
    
    
    // MARK: B. VIEW LOAD / SETUP METHODS ----------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        animator = UIDynamicAnimator(referenceView: view)
        setupFileManager()
        jokeCardHasBeenSwipped()
        readBackData()
        addTheJokes()
    }
    
    func setup() {
        colors = design.palette()
        faceImageArray = design.faceImages()
        backgroundImageArray = design.backgroundImages()
        
        //FOR IPHONE 5/4
        if UIScreen.main.bounds.size.height < 640 {
            jokeCardHeight.constant = 275
            walkthroughViewHeight.constant = 38
            walkthroughViewTopConstraint.constant = 22
            iconHeight.constant = 60
            iconWidth.constant = 60
            jokeLabel.font = jokeLabel.font.withSize(28)
            faceButtonHeight.constant = 80
            faceButtonWidth.constant = 80
            jokeLabel.minimumScaleFactor = 0.5
        }

        if UIScreen.main.bounds.size.height < 568.0 {
            jokeCardHeight.constant = 250
            jokeLabel.font = jokeLabel.font.withSize(26)
            walkthroughViewTopConstraint.constant = 4
        }
        
        //BUTTON ANIMATIONS
        shareMenuButton.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        animations.springWithDelay(0.75, delay: 0.1) { () -> Void in
            self.shareMenuButton.transform = CGAffineTransform.identity
        }
        faceButton.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        animations.springWithDelay(0.75, delay: 0.5) { () -> Void in
            self.faceButton.transform = CGAffineTransform.identity
        }
        favsButton.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        animations.springWithDelay(0.75, delay: 0.25) { () -> Void in
            self.favsButton.transform = CGAffineTransform.identity
        }
        walkthroughView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        animations.springWithDelay(0.75, delay: 0.75) { () -> Void in
            self.walkthroughView.transform = CGAffineTransform.identity
        }
        
        //SHADOWS
        design.jokeCardShadow(jokeCardView)
        design.shadowHappyButton(faceButton)
        design.shadowShareMenuButton(shareMenuButton)
        design.shadowShareButtons(facebookButton)
        design.shadowShareButtons(twitterButton)
        design.shadowShareButtons(smsButton)
        design.shadowShareButtons(settingsButton)
        design.shadowShareMenuButton(favsButton)
        design.jokeCardShadow(walkthroughView)
        
        //SOUNDS
        if let swooshSound = audio.setupAudioPlayerWithFile("Swoosh-2", type:"wav") {    self.swooshSound = swooshSound    }
        if let boingSound = audio.setupAudioPlayerWithFile("Boing", type:"wav") {    self.boingSound = boingSound    }
        if let jokeSound = audio.setupAudioPlayerWithFile("Joke-Sting", type:"wav") {    self.jokeSound = jokeSound    }
        
        //APPLICATION STATES
        notificationCenter.addObserver(self, selector:#selector(DodoViewController.applicationEnteredForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        notificationCenter.addObserver(self, selector:#selector(DodoViewController.applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    
    
    
    
    // MARK: C. VIEW APPEAR / APPLICATION STATE METHODS ----------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        //FOR THE TUTORIAL WALKTHROUGH SCREENS
        let walkthroughFinished = defaults.bool(forKey: "walkthroughFinished")
        if walkthroughFinished == false {
            let firstWalkthrough = defaults.bool(forKey: "secondWalkthrough")
            if firstWalkthrough == false {
                walkthroughView.isHidden = false
                walkthroughSetup(1)
            }
        }
    }
    
    func applicationEnteredForeground() {
        newColor()
        animations.springWithDelay(0.75, delay: 0.1) { () -> Void in
            self.shareMenuButton.transform = CGAffineTransform.identity
        }
        animations.springWithDelay(0.75, delay: 0.25) { () -> Void in
            self.favsButton.transform = CGAffineTransform.identity
        }
        animations.springWithDelay(0.75, delay: 0.5) { () -> Void in
            self.faceButton.transform = CGAffineTransform.identity
        }
        animations.spring(0.75) { () -> Void in
            self.jokeCardView.transform = CGAffineTransform.identity
        }
    }
    
    func applicationDidEnterBackground() {
        newFace()
        self.jokeIndex = randomDigit.selectRandomDigit(jokesArray.count)
        loadJokeAndIcon(jokeIndex)
        self.shareMenuButton.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        self.faceButton.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        self.favsButton.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        self.jokeCardView.transform = scale.concatenating(translate)
    }
    
    
    
    
    
    // MARK: D. LOAD JOKES METHOD ----------------------------------------------------------------------
    
    func addTheJokes() {
        self.jokeIndex = self.randomDigit.selectRandomDigit(self.jokesArray.count)
        self.loadJokeAndIcon(self.jokeIndex)
    }
    

    
    
    
    // MARK: E. NEW JOKE/GESTURE METHODS -----------------------------------------------------------------------------------------
    
    func refreshView() {
        //THIS METHOD IS CALLED WHEN A NEW JOKE IS NEEDED
        
        showAnswer = true
        swooshSound?.play()
        animator.removeAllBehaviors()
        snapBehavior = UISnapBehavior(item: jokeCardView, snapTo: view.center)
        attachmentBehavior.anchorPoint = view.center
        jokeCardView.center = view.center
        loadJokeAndIcon(randomDigit.selectRandomDigit(jokesArray.count))
        jokeCardHasBeenSwipped()
        
        //2ND PART OF THE TUTORIAL WALKTHROUGH SCREENS -> "Swipe the card down for a new joke"
        let walkthroughFinished = defaults.bool(forKey: "walkthroughFinished")
        if walkthroughFinished == false {
            let secondWalkthrough = defaults.bool(forKey: "secondWalkthrough")
            let thirdWalkthrough = defaults.bool(forKey: "thirdWalkthrough")
            if thirdWalkthrough == false && secondWalkthrough == true {
                walkthroughSetup(3)
            }
        }
    }
    
    func loadJokeAndIcon(_ newJokeIndex: Int) {
            jokeIndex = newJokeIndex
            self.jokeLabel?.text = self.jokesArray[jokeIndex].joke
            self.iconImage.image = UIImage(named: jokesArray[self.jokeIndex].icon)
    }
    
    func newFace() {
        faceIndex = randomDigit.selectRandomDigit(8)
        let nextFace = faceImageArray[faceIndex!]
        self.faceButton.setImage(nextFace, for: UIControlState())
    }
    
    func jokeCardHasBeenSwipped(){
        newColor()
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        jokeCardView.transform = scale.concatenating(translate)
        animations.spring(0.75) { () -> Void in
            self.jokeCardView.transform = CGAffineTransform.identity
        }
    }
    
    func newColor(){
        colorIndex = randomDigit.selectRandomDigit(8)
        jokeCardView.backgroundColor = colors[colorIndex!]
        let nextImage = backgroundImageArray[colorIndex!]
        animations.backgroundImageTransition(backgroundImage) { () -> Void in
            self.backgroundImage.image = nextImage
        }
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let jokeCard = jokeCardView
        let location = sender.location(in: view)
        let boxLocation = sender.location(in: jokeCardView)
        
        if jokesArray.count > 0 {
            if sender.state == UIGestureRecognizerState.began {
                animator.removeAllBehaviors()
                let centerOffset = UIOffsetMake(boxLocation.x - (jokeCard?.bounds.midX)!, boxLocation.y - (jokeCard?.bounds.midY)!)
                attachmentBehavior = UIAttachmentBehavior(item: jokeCard!, offsetFromCenter: centerOffset, attachedToAnchor: location)
                attachmentBehavior.frequency = 0
                animator.addBehavior(attachmentBehavior)
                
            } else if sender.state == UIGestureRecognizerState.changed {
                attachmentBehavior.anchorPoint = location
                
            } else if sender.state == UIGestureRecognizerState.ended {
                animator.removeBehavior(attachmentBehavior)
                snapBehavior = UISnapBehavior(item: jokeCard!, snapTo: view.center)
                animator.addBehavior(snapBehavior)
                let translation = sender.translation(in: view)
                if translation.y > 100 {
                    let gravity = UIGravityBehavior(items: [jokeCardView])
                    gravity.gravityDirection = CGVector(dx: 0, dy: self.view.frame.height)
                    animator.addBehavior(gravity)
                    
                    animations.delay(0.3, closure: { () -> () in
                        self.refreshView()
                    })
                }
            }
        }
    }
    
    
    
    
    
    // MARK: F. HAPPY BUTTON PRESSED METHOD -------------------------------------------------------------------------------------
    
    @IBAction func happyButtonPressed(_ sender: UIButton) {
        if jokesArray.count > 0 {
            faceButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            jokeLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            animations.springHappyButton(0.9, spring: 0.4) { () -> Void in
                self.faceButton.transform = CGAffineTransform.identity
            }
            animations.springHappyButton(0.5, spring: 0.9) { () -> Void in
                self.jokeLabel.transform = CGAffineTransform.identity
            }
            newFace()
            
            if showAnswer == true {
                jokeSound?.play()
                jokeLabel?.text = self.jokesArray[jokeIndex].answer
                showAnswer = false
            } else {
                boingSound?.play()
                jokeLabel?.text = self.jokesArray[jokeIndex].joke
                showAnswer = true
            }
        
            //1ST PART OF THE TUTORIAL WALKTHROUGH SCREENS -> "Tap the face to see the answer"
            let walkthroughFinished = defaults.bool(forKey: "walkthroughFinished")
            if walkthroughFinished == false {
                let secondWalkthrough = defaults.bool(forKey: "secondWalkthrough")
                if secondWalkthrough == false {
                    walkthroughSetup(2)
                }
            }
        }
    }
    
    
    
    
    
    // MARK: G. SEGUE METHOD ------------------------------------------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsModal" {
            maskButtonPressed()
        }
        if segue.identifier == "favoritesModal" {
            audio.buttonClick()
            let destinationVC: FavoritesViewController = segue.destination as! FavoritesViewController
            destinationVC.delegate = self
            let favoritesColorBackground = jokeCardView.backgroundColor
            destinationVC.colorInt = favoritesColorBackground
            destinationVC.favoritesJokesArray = favoriteJokes
        }
    }
    
    
    
    
    
    // MARK: H. FAVORITES METHODS -----------------------------------------------------------------------------------------------
    
    @IBAction func addToFavPressed(_ sender: UIButton) {
        audio.buttonClick()
        addFavsButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.animations.springHappyButton(0.9, spring: 0.4) { () -> Void in
            self.addFavsButton.transform = CGAffineTransform.identity
        }
        
        let newJoke = FavoriteJokes(joke: jokesArray[self.jokeIndex].joke, answer: jokesArray[self.jokeIndex].answer)
        var tempArrayOfFaves = [String]()
        
        //ADD FAV JOKES TO TEMPORARY FAVORITE JOKES ARRAY
        for element in favoriteJokes {
            tempArrayOfFaves.append(element.joke)
        }
        
        //IF FAVORITE JOKES ARRAY CONTAINS THE SAME JOKE DONT DO ANYTHING
        if tempArrayOfFaves.contains(newJoke.joke){
            print("It's already in the favorites!")
        } else {
        //IF NOT, ADD TO FAVORITE JOKES ARRAY
            self.favoriteJokes.append(newJoke)
            persistData()
        }
        
        //3RD PART OF THE TUTORIAL WALKTHROUGH SCREENS -> "Tap the star to add to favs"
        let walkthroughFinished = defaults.bool(forKey: "walkthroughFinished")
        if walkthroughFinished == false {
            let firstWalkthrough = defaults.bool(forKey: "firstWalkthrough")
            let secondWalkthrough = defaults.bool(forKey: "secondWalkthrough")
            let thirdWalkthrough = defaults.bool(forKey: "thirdWalkthrough")
            if secondWalkthrough == true && thirdWalkthrough == true && firstWalkthrough == true {
                defaults.set(true, forKey: "walkthroughFinished")
                walkthroughView.isHidden = true
            }
        }
    }
    
    func deleteJokeFromFavoritesArray(_ index: Int){
        self.favoriteJokes.remove(at: index)
        persistData()
    }
    
    
    
    
    
    // MARK: I. SHARE/MASK METHODS -----------------------------------------------------------------------------------------
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        audio.buttonClick()
        if maskButton.isHidden == true {
            maskButton.isHidden = false
            maskButton.alpha = 0
            animations.spring(0.75) { () -> Void in
                self.jokeCardView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.maskButton.alpha = 1
                self.shareMenuButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
                self.animations.shareButtonAnimation(self.settingsButton, translate1: -86, translate2: -23)
                self.animations.shareButtonAnimation(self.facebookButton, translate1: -81, translate2: 38)
                self.animations.shareButtonAnimation(self.twitterButton, translate1: -38, translate2: 81)
                self.animations.shareButtonAnimation(self.smsButton, translate1: 23, translate2: 86)
            }
        } else {
            maskButtonPressed()
        }
    }
    
    @IBAction func maskButtonPressed() {
        audio.buttonClick()
        animations.spring(0.75) {
            self.jokeCardView.transform = CGAffineTransform.identity
            self.maskButton.alpha = 0
            self.maskButton.isHidden = true
            self.shareMenuButton.transform = CGAffineTransform.identity
            self.animations.shareButtonHideAnimation(self.settingsButton)
            self.animations.shareButtonHideAnimation(self.facebookButton)
            self.animations.shareButtonHideAnimation(self.twitterButton)
            self.animations.shareButtonHideAnimation(self.smsButton)
        }
    }
    
    @IBAction func twitterButtonPressed(_ sender: UIButton) {
        maskButtonPressed()
        if jokesArray.count > 0 {
            sharing.twitterAction(self, joke: self.jokesArray[self.jokeIndex].joke)
        }
    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        maskButtonPressed()
        if jokesArray.count > 0 {
            sharing.facebookAction(self, joke: self.jokesArray[self.jokeIndex].joke)
        }
    }
    
    @IBAction func smsButtonPressed(_ sender: UIButton) {
        maskButtonPressed()
        if jokesArray.count > 0 {
            sharing.sendText(self, joke: self.jokesArray[self.jokeIndex].joke)
        }
    }
    
    
    
    
    
    // MARK: J. FILE MANAGER / PERSISTENCE METHODS ------------------------------------------------------------------------------
    
    func setupFileManager() {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            saveFile = documentDirectory.appendingPathComponent("favorite-jokes.bin")
        } catch {
            print("error: setupFileManager")
        }
    }
    
    func persistData(){
        if let saveFile = saveFile {
            let libraryData = NSKeyedArchiver.archivedData(withRootObject: favoriteJokes)
            try? libraryData.write(to: saveFile, options: [.atomic])
        }
    }
    
    func readBackData(){
        do {
            if let saveFile = saveFile {
                let libraryReadData = try Data(contentsOf: saveFile, options: .mappedIfSafe)
                favoriteJokes = NSKeyedUnarchiver.unarchiveObject(with: libraryReadData) as! [FavoriteJokes]
            }
        } catch {
            print("There are no favorites saved yet!")
        }
    }
    
    
    
    
    
    // MARK: K. WALKTHROUGH METHOD -------------------------------------------------------------------------
    
    func walkthroughSetup(_ walkthroughIndex: Int) {
        if walkthroughIndex == 1 {
            walkthroughLabel.text = "Tap the face to see the answer"
            defaults.set(true, forKey: "firstWalkthrough")
            
        } else if walkthroughIndex == 2 {
            walkthroughView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            animations.springHappyButton(0.9, spring: 0.4) { () -> Void in
                self.walkthroughView.transform = CGAffineTransform.identity
            }
            walkthroughLabel.text = "Swipe the card down for a new joke"
            defaults.set(true, forKey: "secondWalkthrough")
            
        } else if walkthroughIndex == 3 {
            walkthroughView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            animations.springHappyButton(0.9, spring: 0.4) { () -> Void in
                self.walkthroughView.transform = CGAffineTransform.identity
            }
            walkthroughLabel.text = "Tap the star to add to favs"
            defaults.set(true, forKey: "thirdWalkthrough")
            
        } else {
            return
        }
    }
}

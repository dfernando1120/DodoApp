//
//  Animations.swift
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
import UIKit


class Animations {

    func spring(_ duration: TimeInterval, animations: (() -> Void)!) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseOut, animations: {
            animations()
            }, completion: { finished in
        })
    }
    
    func shareButtonAnimation(_ button: UIButton, translate1: CGFloat, translate2: CGFloat) {
        button.isHidden = false
        button.alpha = 1
        button.transform = CGAffineTransform(translationX: translate1, y: translate2)
    }
    
    func shareButtonHideAnimation(_ button: UIButton) {
        button.alpha = 0
        button.transform = CGAffineTransform.identity
    }
    
    func springWithDelay(_ duration: TimeInterval, delay: TimeInterval, animations: (() -> Void)!) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            animations()
            }, completion: { finished in
        })
    }
    
    func springHappyButton(_ duration: TimeInterval, spring: CGFloat, animations: (() -> Void)!) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: spring, initialSpringVelocity: 6, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            animations()
            }, completion: { finished in
        })
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    //CHANGE BACKGROUND
    func backgroundImageTransition(_ backgroundImageView: UIImageView, animations: (() -> Void)!) {
        UIView.transition(with: backgroundImageView, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            animations()
            }, completion: nil)
    }
}

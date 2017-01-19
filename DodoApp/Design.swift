//
//  Design.swift
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


class Design {
    
    //SHADOWS
    func jokeCardShadow(_ view: UIView) {
        view.layer.shadowOpacity = 0.5
        viewShadowColorAndSize(view)
    }
    
    func shadowHappyButton(_ view: UIView) {
        view.layer.shadowRadius = 9
        view.layer.shadowOffset = CGSize(width: 0, height: 15)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.black.cgColor
    }
    
    func shadowShareMenuButton(_ view: UIView) {
        view.layer.shadowOpacity = 0.5
        viewShadowColorAndSize(view)
    }
    
    func shadowShareButtons(_ view: UIView) {
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
    }
    
    //COLORS
    func colorFromRGB(_ r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(Float(r) / 255), green: CGFloat(Float(g) / 255), blue: CGFloat(Float(b) / 255), alpha: 1)
    }
    
    func palette() -> [UIColor] {
        let palette = [
            colorFromRGB(241, g: 155, b: 44),   //ORANGE
            colorFromRGB(26, g: 188, b: 156),   //TEAL
            colorFromRGB(46, g: 204, b: 113),   //GREEN
            colorFromRGB(231, g: 76, b: 60),    //RED
            colorFromRGB(165, g: 198, b: 59),   //LIME
            colorFromRGB(244, g: 124, b: 195),  //PINK
            colorFromRGB(0, g: 192, b: 228),    //BLUE
            colorFromRGB(240, g: 195, b: 48)    //YELLOW
        ]
        return palette
    }
    
    //BACKGROUND IMAGES
    func backgroundImages() -> [UIImage] {
        let ORANGE = UIImage(named: "bkgd-orange.png")!
        let TEAL = UIImage(named: "bkgd-teal.png")!
        let GREEN = UIImage(named: "bkgd-green.png")!
        let RED = UIImage(named: "bkgd-red.png")!
        let LIME = UIImage(named: "bkgd-lime.png")!
        let PINK = UIImage(named: "bkgd-pink.png")!
        let BLUE = UIImage(named: "bkgd-blue.png")!
        let YELLOW = UIImage(named: "bkgd-yellow.png")!
        let backgroundImages = [ORANGE, TEAL, GREEN, RED, LIME, PINK, BLUE, YELLOW]
        return backgroundImages
    }
    
    //FACE BUTTON
    func faceImages() -> [UIImage] {
        let face1 = UIImage(named: "face-1")!
        let face2 = UIImage(named: "face-2")!
        let face3 = UIImage(named: "face-3")!
        let face4 = UIImage(named: "face-4")!
        let face5 = UIImage(named: "face-5")!
        let face6 = UIImage(named: "face-6")!
        let face7 = UIImage(named: "face-7")!
        let face8 = UIImage(named: "face-8")!
        let faceImages = [face1, face2, face3, face4, face5, face6, face7, face8]
        return faceImages
    }
    
    //HELPER METHODS
    func viewShadowColorAndSize(_ view: UIView) {
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = UIColor.black.cgColor
    }
    
    func ovalPath(_ view: UIView) {
        let ovalPath = UIBezierPath(ovalIn: view.bounds).cgPath
        view.layer.shadowPath = ovalPath
    }
}

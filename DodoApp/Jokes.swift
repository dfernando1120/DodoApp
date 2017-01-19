//
//  Jokes.swift
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


class Jokes {
    
    var joke = ""
    var answer = ""
    var icon = ""
    
    init (joke: String, answer: String, icon: String) {
        self.joke = joke
        self.answer = answer
        self.icon = icon
    }
}

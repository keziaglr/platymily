//
//  Prompt.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation

struct Prompt { private init() {} }

extension Prompt {
    struct TwoTruthsOneLie {
        static let title = "Two Truths One Lie"
        static let inputTruth = "Input two truths about yourself"
        static let inputLie = "Input a lie about yourself"
        static let chooseLie = "Select the LIE"
        static let parent = "P"
        static let child = "C"
        
        private init() {}
    }
}

extension Prompt {
    struct Prologue{
        static let title = "PROLOGUE"
        static let paragraph1 = "In a magical world filled with wonder and magic called Adeyca,  a small family of Platypus that lusted for adventure lived their happy story together. The parent and child would spend their days exploring dungeons and learning new things as their bond grew stronger with each passing day."
        static let paragraph2 = "But one day, as they made their way through a mysterious dungeon, they came across a cursed artifact that has a majestic look. As the child grabbed it, a blinding light flashed and in a glimpse of an eye, their fate changed."
        static let paragraph3 = "The parents and child started to argue with each other constantly, making their once-strong bond strained and found themselves at odds with each other -- at every opportunity."
        static let paragraph4 = "They later discovered that the dungeon  was the work of Platywiz, the Great Platypus Wizard, and he is the one who created the artificat. After countless days of adventure, they found the wizard and begged him to lift the curse. "
        static let paragraph5 = "The wizard, moved by their sheer determination, gave the family a series of trials. The family accepted those requests and set out to another adventure in hope of breaking the curse."
    }
}

extension Prompt {
    struct Button {
        static let confirm = "Confirm"
        static let playAgain = "Play Again"
        static let startTrial = "Start Trial"
        static let gacha = "Gacha"
        static let equip = "Equip"
        static let continueBtn = "Continue"
        
        private init() {}
    }
}

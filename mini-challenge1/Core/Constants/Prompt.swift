//
//  Prompt.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation

struct Prompt { private init() {} }

extension Prompt {
    struct TwoTruthOneLies {
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
    struct Button {
        static let confirm = "Confirm"
        static let playAgain = "Play Again"
        static let startTrial = "Start Trial"
        static let gacha = "Gacha"
        static let equip = "Equip"
        
        private init() {}
    }
}

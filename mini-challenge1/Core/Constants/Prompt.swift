//
//  Prompt.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation

struct Prompt { private init() {} }

extension Prompt {
    struct Games{
        static let game1 = SwimPlatypus.self
        static let game2 = GuessTheWord.self
        static let game3 = ConnectFOUR.self
        static let game4 = CatchGacha.self
        static let game5 = TwoTruthsOneLie.self
        static let game6 = TheLastTrial.self
    }
}

extension Prompt{
    struct Role{
        static let platy = "Platypus"
        static let puggle = "Puggle"
    }
}

extension Prompt {
    struct TwoTruthsOneLie {
        static let title = "2 Truths 1 Lie"
        static let rules = "1. Player will be given 3 boxes to fill.\n2. Player have to write down one sentence of lie in the first box and two sentences of truth in the second and third boxes.\n3. Other Player would try to guess Player’s lie.\n4. If the Player successfully guess the Lie correct, Player will get 10+ point.\n5. The first Player to achieve 30 points will be nominated as the winner."
        static let inputTruth = "Input two TRUTHS about yourself"
        static let inputLie = "Input a LIE about yourself"
        static let chooseLie = "Select the LIE"
        static let parent = "Parent"
        static let child = "Child"
        static let placeholderLie = "e.g. I like candy"
        static let placeholderTruth1 = "e.g. I dislike sweet foods"
        static let placeholderTruth2 = "e.g. I hate candy"
        static let gotPoint = "You got 10+ point"
        private init() {}
    }
}

extension Prompt {
    struct SwimPlatypus {
        static let title = "Swim, Platypus"
        static let rules = "1. Player can only go Upward and Downward. \n2. The faster Player tap, the higher Platypus will swim. Once Player stop, Platypus will swim downward.\n3. If Platypus hit the ground or Coral, Player will lose.\n4. Every time Player successfully pass the Coral, Player will get 1+ point.\n5. Player who has higher point will be nominated as the winner."
        private init() {}
    }
}

extension Prompt {
    struct CatchGacha {
        static let title = "Catch Gacha"
        static let rules = "1. Player can only go Horizontally.\n2. Player will be given 3 Lives.\n3. Every time Player catches a wood, Player will get 1+ point.\n4. If Player is hit by a rock, Player will lose 1 life.\n5. Player who has higher point will be nominated as the winner."
        private init() {}
    }
}

extension Prompt {
    struct GuessTheWord {
        static let title = "Guess the Word"
        static let rules = "1. Each Player will be given a word randomly by the system.\n2. Player would put the phone on their forehead and guess the given word by asking questions to the other Player.\n3. Other Player would have to answer with only Yes, No, and Might Be.\n4. If the Player guess it right, the Player will get 10+ points.\n5. The first Player to achieve 30 points will be nominated as the winner."
        private init() {}
    }
}

extension Prompt {
    struct ConnectFOUR {
        static let title = "Connect FOUR"
        static let rules = "1. Each Player will be given a different color circle.\n2. Each Player can only set a circle once every round and the round continues until a 4 in row is made.\n3. The row can be made vertically/horizontally/or diagonally.\n4. Player can block other Player’s circle from getting 4 in a row.\n5. If the Player connect 4 of same colored discs in a row, the Player will get 10+ points.\n6. The first Player to achieve 30 points will be nominated as the winner."
        
        private init() {}
    }
}

extension Prompt {
    struct TheLastTrial {
        static let title = "The Last Trial"
        static let rules = "1. Player will face Sneky - The Devourer of Platypus.\n2. Player will be given 3 lives and shoot Bubble every once a while to attack Sneky.\n3. Sneky will unleash poison attack and if Player is hit by the attack, Player lose 1 life.\n4. Buffs will randomly appear and might give double attacks or additional life for a limited time.\n5. Each time Sneky is defeated, Player will get 10+ points and Sneky can revive up to 3 times.\n6. The fastest Player to achieve 30 points will be nominated as the winner."
        
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
        static let startChallenge = "Start Challenge"
        static let gacha = "Gacha"
        static let equip = "Equip set"
        static let continueBtn = "Continue"
        static let claimPlatycoin = "Claim Platycoin"
        static let gachaRoll = "1x Roll"
        static let gachaRollAgain = "Roll again"
        
        private init() {}
    }
}


extension Prompt{
    struct Rules{
        static let title = "Rules & Regulations"
    }
    
    struct Navbar{
        static let map = "Map"
        static let platyroll = "Platyroll"
        static let profile = "Profile"
    }
}


extension Prompt{
    struct GameResult{
        static let win = "The winner is"
        static let tie = "It is a tie!"
        static let tieWinner = "DUO WINNER"
    }
}

extension Prompt{
    struct GameTurn{
        static let turn = "It’s your turn!"
        static let child = "THE CHILD"
        static let parent = "THE PARENT"
        static let tap = "Tap anywhere to continue"
    }
    
    struct Platycoin{
        static let congrats = "Congrats!"
        static let given = "You have been given"
        static let platycoin = "PlatyCoin"
        static let tap = "Tap anywhere to continue"
    }
    
    struct Story{
        static let texts = ["In a magical world filled with wonder and magic called Adeyca,  a small family of Platypus that lusted for adventure lived their happy story together. Platypus the parent and Puggle the child would spend their days exploring dungeons and learning new things as their bond grew stronger with each passing day.", "But one day, as they explore the deep sea of Atlantis, they came across a cursed artifact that has a majestic look at the bottom of the ocean. As the child grabbed it, a blinding light flashed and in a glimpse of an eye, their fate changed.", "The parents and child started to argue with each other constantly, making their once-strong bond strained and found themselves at odds with each other -- at every opportunity.", "They later discovered that the dungeon  was the work of Platywiz, the Great Platypus Wizard, and he is the one who created the artificat. After countless days of adventure, they found the wizard and begged him to lift the curse. ", "The wizard, moved by their sheer determination, gave the family a set of challenges. The family accepted those requests and set out to another adventure in hope of breaking the curse."]
        static let animations = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    }
    
    struct Ending{
        static let texts = ["The journey was tilled with challenges and obstacles but each member of the family never lost sight of their goal. Throughout the adventure, they showed care and support to each other", "Upon completing the final trial, they arrived back to the wizard's tower. But the wizard was nowhere to be found and there was only a letter that said:", "\"There was no such curse in the first place. Even if there is a strong curse, your bond is stronger,\" written on the first page. \"..my trials are not to test your communication skills nor ability to work together - but your capacity to be caring and understanding.\"", "The parent and child looked at each other. The warmth that once disappeared, came to the surface once again. They left the tower with a thankful smile on their face and a single mind - the trials that brought them back together shall be the new strength to overcome difficulties in the upcoming journeys"]
        static let animations = ["end1", "end2", "end3", "end4"]
    }
}

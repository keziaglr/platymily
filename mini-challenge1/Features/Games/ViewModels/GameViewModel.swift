//
//  GameViewModel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 02/05/23.
//

import Foundation
import Combine
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var coin = 0
    @Published var showPopup = true
    @StateObject var vm = MapViewModel()
    
    init() {
        self.coin = randomCoin()
    }
    func getHigherScore(scorePlaty: Int, scorePuggle: Int, game: Int) -> Int{
        return scorePlaty >= scorePuggle ? scorePlaty : scorePuggle
    }
    
    func randomCoin() -> Int {
        let rand = Double.random(in: 0..<1)
        var coin = 0
            if rand < 0.5 {
                coin = 1 // 50% chance
            } else if rand < 0.85 {
                coin = 1 // 35% chance
            } else if rand < 0.95 {
                coin = 2 // 10% chance
            } else {
                coin = 3 // 5% chance
            }
        return coin
    }
    
    
    func checkChance(scorePlaty: Int, scorePuggle: Int) -> Bool{
        if scorePlaty != 0 || scorePuggle != 0 || coin != 0{
            showPopup = true
            return true
        }else {
            showPopup = false
            return false
        }
    }
}

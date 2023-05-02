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
    @StateObject var vm = MapViewModel()
    
    init(coin: Int = 0, vm: MapViewModel = MapViewModel()) {
        self.coin = randomCoin()
    }
    func getHigherScore(scorePlaty: Int, scorePuggle: Int, game: Int) -> Int{
        return scorePlaty >= scorePuggle ? scorePlaty : scorePuggle
    }
    
    func randomCoin() -> Int {
        let rand = Double.random(in: 0..<1)
        DispatchQueue.main.async { [self] in
            if rand < 0.5 {
                coin = 0 // 50% chance
            } else if rand < 0.85 {
                coin = 1 // 35% chance
            } else if rand < 0.95 {
                coin = 2 // 10% chance
            } else {
                coin = 3 // 5% chance
            }
            
        }
        return coin
    }
}

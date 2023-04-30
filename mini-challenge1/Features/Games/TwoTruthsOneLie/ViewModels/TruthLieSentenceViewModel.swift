//
//  TruthLieSentenceViewModel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation
import Combine
import SwiftUI

class TruthLieSentenceViewModel: ObservableObject {
    @Published var sentence = ""
    @Published var isLie = false
    @Published var color = AppColor.orange
    @Published var pointPlaty = 0
    @Published var pointPuggle = 0
    var sentenceRepository = TruthLieSentenceRepository()
    
    func saveResult() {
        let newSentence = TruthLieSentence(
            savedAt: Date(), sentence: sentence, isLie: isLie, color: color)
        sentenceRepository.add(newSentence)
    }
    
    func platyCorrect(){
        pointPlaty += 10
    }
    
    func puggleCorrect(){
        pointPuggle += 10
    }
    
    func resetAll(){
        sentenceRepository.savedSentences.removeAll()
    }
}

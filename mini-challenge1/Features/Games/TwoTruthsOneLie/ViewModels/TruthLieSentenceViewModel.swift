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
    var sentenceRepository = TruthLieSentenceRepository()
    
    func saveResult() {
        let newSentence = TruthLieSentence(
            savedAt: Date(), sentence: sentence, isLie: isLie, color: color)
        sentenceRepository.add(newSentence)
    }
    
    func resetAll(){
        sentenceRepository.savedSentences.removeAll()
    }
}

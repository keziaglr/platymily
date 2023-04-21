//
//  TruthLieSentenceRepository.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation

struct TruthLieSentenceRepository {
    var savedSentences :[TruthLieSentence] = []
    
    mutating func add(_ truthLieSentence: TruthLieSentence) {
        savedSentences.insert(truthLieSentence, at: 0)
    }
}


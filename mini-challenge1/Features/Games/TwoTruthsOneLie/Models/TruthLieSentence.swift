//
//  TruthLieSentence.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import Foundation
import SwiftUI

struct TruthLieSentence: Identifiable, Hashable {
    let id = UUID()
    var savedAt: Date
    var sentence: String
    var isLie: Bool
    var color: Color
}

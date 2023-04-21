//
//  mini_challenge1App.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

@main
struct mini_challenge1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())
        }
    }
}

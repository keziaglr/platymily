//
//  TwoTruthsOneLie.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct TwoTruthsOneLie: View {
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    @State var movePage = 1
    @State var platyTurn : Bool = true
    @State var showPopup : Bool = true
    var body: some View {
        NavigationView {
            if movePage == 1 || movePage == 2 {
                ZStack{
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                    VStack{
                        TitleGame(title: Prompt.TwoTruthsOneLie.title)
                        .padding(.bottom, 30)
                        
                        HStack {
                            TruthLieTurn(role: Prompt.Role.platy, truthLieSentenceViewModel: truthLieSentenceViewModel)
                                .opacity(platyTurn ? 1.0 : 0.5)
                            Spacer()
                            TruthLieTurn(role: Prompt.Role.puggle, truthLieSentenceViewModel: truthLieSentenceViewModel)
                                .opacity(platyTurn ? 0.5 : 1.0)
                        }.padding(.horizontal, 20)
                        
                        if movePage == 1{
                            InputSentences(truthLieSentenceViewModel: truthLieSentenceViewModel, movePage: $movePage, showPopup: $showPopup, platyTurn: $platyTurn)
                                .frame(minWidth: 300)
                        }else if movePage == 2{
                            SelectSentence(truthLieSentenceViewModel: truthLieSentenceViewModel, movePage: $movePage, platyTurn: $platyTurn, showPopup: $showPopup, shuffledSentences: truthLieSentenceViewModel.sentenceRepository.savedSentences.shuffled())
                                .frame(minWidth: 300)
                        }
                        Spacer()
                        NavBar()
                        
                        
                    }
                    if showPopup{
                        PopUpGameTurn(platyTurn: platyTurn, showPopup: $showPopup)
                    }
                }
            }else{
                GameResultView(scorePlaty: truthLieSentenceViewModel.pointPlaty, scorePuggle: truthLieSentenceViewModel.pointPuggle, playAgain: AnyView(TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())), game: 4)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct TwoTruthsOneLie_Previews: PreviewProvider {
    static var previews: some View {
        TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())
    }
}

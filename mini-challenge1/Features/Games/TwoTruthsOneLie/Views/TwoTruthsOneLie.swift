//
//  TwoTruthsOneLie.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct TwoTruthsOneLie: View {
    @State private var name = ""
    @State private var selectedP = false
    @State private var selectedC = true
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    @State private var movePage = false
    var body: some View {
        NavigationView {
            ZStack{
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    TitleGame(title: Prompt.TwoTruthOneLies.title)
                    .padding(.bottom, 30)
                    HStack {
                        Button(action: {
                            if !movePage{
                                selectedP.toggle()
                                selectedC = selectedC ? false : true
                            }

                        }, label:{ RectangleButton(text:Prompt.TwoTruthOneLies.parent, selected: $selectedP)
                        }).disabled(movePage)
                        
                        Button(action: {
                            if !movePage{
                                selectedC.toggle()
                                selectedP = selectedP ? false : true
                            }

                        }, label:{ RectangleButton(text:Prompt.TwoTruthOneLies.child, selected: $selectedC)
                        }).disabled(movePage)
                    }
                    
                    
                    if !movePage{
                        InputSentences(truthLieSentenceViewModel: truthLieSentenceViewModel, movePage: $movePage)
                    }else{
                        SelectSentence(truthLieSentenceViewModel: truthLieSentenceViewModel, movePage: $movePage, shuffledSentences: truthLieSentenceViewModel.sentenceRepository.savedSentences.shuffled())
                    }
                    
                    
                }
            }
        }
    }
}

struct TwoTruthsOneLie_Previews: PreviewProvider {
    static var previews: some View {
        TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())
    }
}

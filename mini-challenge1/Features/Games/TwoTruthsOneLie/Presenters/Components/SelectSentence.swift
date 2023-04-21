//
//  SelectSentence.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct SelectSentence: View {
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    @State var color = AppColor.green
    @Binding var movePage : Bool
    @State var showColor = false
    @State var shuffledSentences : [TruthLieSentence]
    
    var body: some View {
        VStack{
            Text(Prompt.TwoTruthOneLies.chooseLie)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical, 30)
            ForEach(shuffledSentences, id: \.self) { sentence in
                Button {
                    showColor = true
                } label: {
                    TruthLieButton(text: sentence.sentence, color: sentence.isLie ? AppColor.green : AppColor.red, showColor: $showColor)
                }
            }
            
            if showColor {
                Button(action: {
                    self.movePage = false
                    truthLieSentenceViewModel.resetAll()
                },label:{
                    RoundedButton(text: Prompt.Button.playAgain)
                })
                .padding(.top, 80)
            }
            
            
        }
    }
}

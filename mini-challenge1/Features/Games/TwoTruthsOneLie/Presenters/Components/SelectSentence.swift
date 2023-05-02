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
    @Binding var movePage : Int
    @Binding var platyTurn : Bool
    @Binding var showPopup : Bool
    @State var showColor = false
    @State var shuffledSentences : [TruthLieSentence]
    @State var isCorrect = false
    @State var showWinView = false    
    var body: some View {
        VStack{
            Text(Prompt.TwoTruthsOneLie.chooseLie)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 18))
                .padding(.vertical, 30)
                .multilineTextAlignment(.leading)
            ForEach(shuffledSentences, id: \.self) { sentence in
                Button {
                    showColor = true
                    if sentence.isLie == true {
                        isCorrect = true
                        if platyTurn {
                            truthLieSentenceViewModel.platyCorrect()
                        }else{
                            truthLieSentenceViewModel.puggleCorrect()
                        }
                        if truthLieSentenceViewModel.pointPlaty >= 30 || truthLieSentenceViewModel.pointPuggle >= 30 {
                            self.movePage = 3
                        }
                    }
                } label: {
                    TruthLieButton(text: sentence.sentence, color: sentence.isLie ? AppColor.green : AppColor.red, showColor: $showColor)
                        .padding(.vertical, 5)
                }
            }
            
            
            Button(action: {
                self.movePage = 1
                self.showPopup = true
                truthLieSentenceViewModel.resetAll()
            },label:{
                RoundedButton(text: Prompt.Button.continueBtn)
            })
            .padding(.top, 80)
            .opacity(showColor ? 1.0 : 0.0)
            
            Text(Prompt.TwoTruthsOneLie.gotPoint)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.medium, size: 18))
                .opacity(isCorrect ? 1.0 : 0.0)
                .padding(.top, 5)
                .animation(Animation.easeIn, value: isCorrect)
                
            
            
        }
    }
}

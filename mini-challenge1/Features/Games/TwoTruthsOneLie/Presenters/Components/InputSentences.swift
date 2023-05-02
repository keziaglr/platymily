//
//  InputSentences.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct InputSentences: View {
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    @Binding var movePage : Int
    @Binding var showPopup : Bool
    @Binding var platyTurn : Bool
    @State var sentences = ["","",""]
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(Prompt.TwoTruthsOneLie.inputLie)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .font(.custom(AppFont.bold, size: 18))
                CustomTextField(text: $sentences[2], placeholder: Prompt.TwoTruthsOneLie.placeholderLie)
            }
            .padding(.vertical, 30)
            VStack(alignment: .leading){
                Text(Prompt.TwoTruthsOneLie.inputTruth)
                    .foregroundColor(.white)
                    .font(.custom(AppFont.bold, size: 18))
                    .padding(.leading, 20)
                CustomTextField(text: $sentences[0], placeholder: Prompt.TwoTruthsOneLie.placeholderTruth1)
                CustomTextField(text: $sentences[1], placeholder: Prompt.TwoTruthsOneLie.placeholderTruth2)
            }
            .padding(.bottom, 80)
           
            Button(action: {
                
                if sentences[0] != "" && sentences[1] != "" && sentences[2] != ""{
                    for i in 0...2{
                        truthLieSentenceViewModel.sentence = sentences[i]
                        if i == 2{
                            truthLieSentenceViewModel.isLie = true
                        }else{
                            truthLieSentenceViewModel.isLie = false
                        }
                        truthLieSentenceViewModel.saveResult()
                    }
                    self.showPopup = true
                    self.movePage = 2
                    platyTurn.toggle()
                }
            },label:{
                RoundedButton(text: Prompt.Button.confirm)
            })
        }
    }
}

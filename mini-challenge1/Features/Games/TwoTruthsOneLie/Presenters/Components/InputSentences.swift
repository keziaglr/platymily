//
//  InputSentences.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct InputSentences: View {
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    @Binding var movePage : Bool
    @State var sentences = ["","",""]
    
    var body: some View {
        VStack{
            VStack{
                Text(Prompt.TwoTruthsOneLie.inputTruth)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                CustomTextField(text: $sentences[0])
                CustomTextField(text: $sentences[1])
                                    
            }
            .padding(.vertical, 50)
            VStack{
                Text(Prompt.TwoTruthsOneLie.inputLie)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                CustomTextField(text: $sentences[2])
            }
            .padding(.bottom, 80)
           
            Button(action: {
                for i in 0...2{
                    truthLieSentenceViewModel.sentence = sentences[i]
                    if i == 2{
                        truthLieSentenceViewModel.isLie = true
                    }else{
                        truthLieSentenceViewModel.isLie = false
                    }
                    truthLieSentenceViewModel.saveResult()
                }
                
                    self.movePage = true
            },label:{
                RoundedButton(text: Prompt.Button.confirm)
            })
        }
    }
}

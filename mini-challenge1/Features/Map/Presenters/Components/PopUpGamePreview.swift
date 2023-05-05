//
//  PopUpGamePreview.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 30/04/23.
//

import SwiftUI

struct PopUpGamePreview: View {
    @Binding var title : String
    @State var rules : String
    @State var image : String
    @Binding var showPopup : Bool
    @ObservedObject var mc : MusicController
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showPopup = false
                }
            VStack{
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .shadow(radius: 10)
                Text(title)
                    .font(.custom(AppFont.bold, size: 28))
                    .foregroundColor(AppColor.navy)
                VStack (alignment: .leading){
                    Text(Prompt.Rules.title)
                        .font(.custom(AppFont.bold, size: 16))
                        .foregroundColor(AppColor.navy)
                        .padding(.bottom, 5)
                    Text(rules)
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.navy)
                        .multilineTextAlignment(.leading)
                }.padding(.vertical, 5)
                NavigationLink {
                    if title == Prompt.Games.game1.title {
                        SwimPlatypusView(mc: mc)
                    }else if title == Prompt.Games.game2.title {
                        GuessTheWord(mc: mc)
                    }else if title == Prompt.Games.game3.title{
                        ConnectFourView(mc: mc)
                    }else if title == Prompt.Games.game4.title {
                        CatchGacha(mc: mc)
                    }else if title == Prompt.Games.game5.title {
                        TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel(), mc: mc )
                    }else if title == Prompt.Games.game6.title {
                        TheLastTrial(mc: mc)
                    }
                } label: {
                    RoundedButton(text: Prompt.Button.startChallenge)
                }
            }
            .padding(20)
            .frame(width: 350, height: 550)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AppColor.white, lineWidth: 3)
                    .shadow(radius: 10)
                    .background(
                        Image("Background")
                            .resizable()
                            .frame(width: 350, height: 550)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
            )
        }
        
    }
}

//struct PopUpGamePreview_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpGamePreview(title: Prompt.Games.game1.title, rules: Prompt.Games.game1.rules, showPopup: $true)
//    }
//}


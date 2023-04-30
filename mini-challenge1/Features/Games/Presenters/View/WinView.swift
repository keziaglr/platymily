//
//  WinView.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct WinView: View {
    @State var scorePlaty: Int
    @State var scorePuggle: Int
    @State var maxScore: Int
    @State var playAgain: AnyView// = AnyView(SwimPlatypusView())
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    NavBar()
                }
                VStack{
                    Text(Prompt.GameResult.win)
                        .font(.custom(AppFont.bold, size: 14))
                        .foregroundColor(AppColor.white)
                    Text(Prompt.Role.platy)
                        .font(.custom(AppFont.bold, size: 42))
                        .foregroundColor(AppColor.white)
                        .textCase(.uppercase)
                    Image(scorePlaty > scorePuggle ? Prompt.Role.platy : Prompt.Role.puggle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                    ProgressBarWin(score: scorePlaty, maxScore: maxScore,platy: true)
                    ProgressBarWin(score: scorePuggle, maxScore: maxScore, platy: false)
                    NavigationLink {
                        playAgain
                    } label: {
                        RoundedButton(text: Prompt.Button.playAgain)
                    }
                    .padding(.top, 20)

                }.padding(.bottom, 100)
            }
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(scorePlaty: 10, scorePuggle: 20, maxScore: 20, playAgain: AnyView(TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())))
    }
}

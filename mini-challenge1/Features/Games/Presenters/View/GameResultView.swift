//
//  WinView.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct GameResultView: View {
    @State var scorePlaty: Int
    @State var scorePuggle: Int
    @State var playAgain: AnyView
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
                if scorePlaty != scorePuggle {
                    VStack{
                        Text(Prompt.GameResult.win)
                            .font(.custom(AppFont.bold, size: 14))
                            .foregroundColor(AppColor.white)
                        Text(scorePlaty > scorePuggle ? Prompt.Role.platy : Prompt.Role.puggle)
                            .font(.custom(AppFont.bold, size: 42))
                            .foregroundColor(AppColor.white)
                            .textCase(.uppercase)
                        Image(scorePlaty > scorePuggle ? Prompt.Role.platy : Prompt.Role.puggle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250)
                        ProgressBarWin(score: scorePlaty, maxScore: getHigherScore(),platy: true)
                        ProgressBarWin(score: scorePuggle, maxScore: getHigherScore(), platy: false)
                        NavigationLink {
                            playAgain
                        } label: {
                            RoundedButton(text: Prompt.Button.playAgain)
                        }
                        .padding(.top, 20)

                    }.padding(.bottom, 100)
                }else{
                    VStack{
                        Text(Prompt.GameResult.tie)
                            .font(.custom(AppFont.bold, size: 14))
                            .foregroundColor(AppColor.white)
                        Text(Prompt.GameResult.tieWinner)
                            .font(.custom(AppFont.bold, size: 42))
                            .foregroundColor(AppColor.white)
                            .textCase(.uppercase)
                        ZStack {
                            Image(Prompt.Role.platy)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: -50)
                            .frame(width: 200)
                            Image(Prompt.Role.puggle)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: 25, y:10)
                            .frame(width: 120)
                        }
                        ProgressBarWin(score: scorePlaty, maxScore: getHigherScore(),platy: true)
                        ProgressBarWin(score: scorePuggle, maxScore: getHigherScore(), platy: false)
                        NavigationLink {
                            playAgain
                        } label: {
                            RoundedButton(text: Prompt.Button.playAgain)
                        }
                        .padding(.top, 20)

                    }.padding(.bottom, 100)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func getHigherScore() -> Int{
        return scorePlaty >= scorePuggle ? scorePlaty : scorePuggle
    }
}

struct GameResultView_Previews: PreviewProvider {
    static var previews: some View {
        GameResultView(scorePlaty: 20, scorePuggle: 40, playAgain: AnyView(TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())))
    }
}

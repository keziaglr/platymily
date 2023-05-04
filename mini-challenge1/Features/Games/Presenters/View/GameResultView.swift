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
    @State var game: Int
    @StateObject var gvm = GameViewModel()
    @StateObject var mvm = MapViewModel()
    @ObservedObject var mc : MusicController
    @StateObject var pvm = ProfileViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                    .onAppear{
                        mc.playMapMusic()
                    }
                    
                VStack {
                    Spacer()
                    NavBar(mc: mc)
                }.ignoresSafeArea()
                if scorePlaty != scorePuggle {
                    VStack{
                        Text(Prompt.GameResult.win)
                            .font(.custom(AppFont.bold, size: 16))
                            .foregroundColor(AppColor.white)
                        Text(scorePlaty > scorePuggle ? Prompt.Role.platy : Prompt.Role.puggle)
                            .font(.custom(AppFont.bold, size: 42))
                            .foregroundColor(AppColor.white)
                            .textCase(.uppercase)
                        Image(scorePlaty > scorePuggle ? Prompt.Role.platy : Prompt.Role.puggle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250)
                        ProgressBarWin(score: scorePlaty, maxScore: gvm.getHigherScore(scorePlaty: scorePlaty, scorePuggle: scorePuggle, game: game),platy: true, gvm: gvm)
                        ProgressBarWin(score: scorePuggle, maxScore: gvm.getHigherScore(scorePlaty: scorePlaty, scorePuggle: scorePuggle, game: game), platy: false, gvm: gvm)
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
                            .font(.custom(AppFont.bold, size: 16))
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
                                .offset(x: 25, y:25)
                            .frame(width: 150)
                        }
                        ProgressBarWin(score: scorePlaty, maxScore: gvm.getHigherScore(scorePlaty: scorePlaty, scorePuggle: scorePuggle, game: game),platy: true, gvm: gvm)
                        ProgressBarWin(score: scorePuggle, maxScore: gvm.getHigherScore(scorePlaty: scorePlaty, scorePuggle: scorePuggle, game: game), platy: false, gvm: gvm)
                        NavigationLink {
                            playAgain
                        } label: {
                            RoundedButton(text: Prompt.Button.playAgain)
                        }
                        .padding(.top, 20)

                    }.padding(.bottom, 100)
                }
                
                if  gvm.showPopup{
                    PopUpPlatyCoin(coinAmount: gvm.coin, gvm: gvm)
                }
            }.onAppear{
                if scorePlaty != 0 && scorePuggle != 0{
                    pvm.levelUp(index: game)
                    mvm.updateData(index: game, scorePlaty: scorePlaty, scorePuggle: scorePuggle)
                }
                
                if gvm.checkChance(scorePlaty: scorePlaty, scorePuggle: scorePuggle){
                    gvm.showPopup = true
                }
            }
        }.navigationBarBackButtonHidden(true)
    }

}

//struct GameResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameResultView(scorePlaty: 2, scorePuggle: 5, playAgain: AnyView(TwoTruthsOneLie(truthLieSentenceViewModel: TruthLieSentenceViewModel())), game: 1)
//    }
//}

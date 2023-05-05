//
//  ContentView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 23/04/23.
//

import SwiftUI

struct GuessTheWord: View {
    @ObservedObject var mc: MusicController
    @State var showPopup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(AppColor.blue)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                VStack (spacing: UIScreen.main.bounds.height/4) {
                    Image("Puggle")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(x: -2, y: 2)
                        .rotationEffect(.degrees(270))
                        .offset(x: 150)
                    TitleGame(title: Prompt.Games.game2.title)
                        .scaledToFit()
                        .scaleEffect(2.3)
                        .rotationEffect(.degrees(270))
                        .offset(x: -50)
                    
                    Image("Platypus")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(2.3)
                        .rotationEffect(.degrees(270))
                        .offset(x: 150)
                }
                NavigationLink(destination: GameView(mc: mc)){
                    Image("Play_Button")
                }.rotationEffect(.degrees(270))
                    .offset(x: 125)
                
                PopUpReadySetGo(start: $showPopup, potrait: false)
                    .opacity(showPopup ? 0.0 : 1.0)
            }
            
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .bottom)
            .onAppear{
                mc.playGameMusic()
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GuessTheWord_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheWord(mc: MusicController())
    }
}

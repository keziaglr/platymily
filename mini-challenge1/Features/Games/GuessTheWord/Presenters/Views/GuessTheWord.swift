//
//  ContentView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 23/04/23.
//

import SwiftUI

struct GuessTheWord: View {
    @ObservedObject var mc: MusicController
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                
                    NavigationLink(destination: GameView(mc: mc)){
                        Image("Play_Button")
                    }
                    .rotationEffect(.degrees(360))
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 500, alignment: .bottom)
                .padding(.bottom, 150)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("GuessTheWord_Background")
                .resizable()
                .frame(width: 900, height: 500)
                .aspectRatio(contentMode: .fill)
            )
            .onAppear{
                mc.playGameMusic()
            }
            .ignoresSafeArea()
            .rotationEffect(.degrees(270))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GuessTheWord_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheWord(mc: MusicController())
    }
}

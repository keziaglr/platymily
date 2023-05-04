//
//  ContentView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 23/04/23.
//

import SwiftUI

struct GuessTheWord: View {
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    
                    NavigationLink(destination: ChooseView()){
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
            .ignoresSafeArea()
            .rotationEffect(.degrees(270))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GuessTheWord_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheWord()
    }
}

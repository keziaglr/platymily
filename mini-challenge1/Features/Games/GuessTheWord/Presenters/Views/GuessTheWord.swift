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
                    Spacer()
                    
                    NavigationLink(destination: ChooseView()){
                        Image("Play_Button")
                    }
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("GuessTheWord_Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
        }
    }
}

struct GuessTheWord_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheWord()
    }
}

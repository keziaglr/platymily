//
//  ChooseView.swift
//  GuessWord
//
//  Created by Nicholas Yvees on 27/04/23.
//

import SwiftUI

struct ChooseView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("SELECT CHARACTER")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                
                NavigationLink(destination: GameView()) {
                    Text("PLATYPUS")
                        .padding(10)
                        .padding(.leading, 70)
                        .padding(.trailing, 70)
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .background(.orange)
                        .cornerRadius(20)
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                    }
                }
                
                NavigationLink(destination: GameView()) {
                    Text("PUGGLE")
                        .padding(10)
                        .padding(.leading, 85)
                        .padding(.trailing, 85)
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .background(.orange)
                        .cornerRadius(20)
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseView()
    }
}

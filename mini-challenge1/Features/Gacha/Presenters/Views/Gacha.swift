//
//  ContentView.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct Gacha: View {
    
    @StateObject var mc = MusicController()
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Platyroll")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                Image("GachaMachine")
                    .resizable()
                    .scaledToFit()
                NavigationLink(destination: GachaResult(mc: mc)){
                    Text("1x Roll")
                        .padding(10)
                        .padding(.leading, 70)
                        .padding(.trailing, 70)
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(20)
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                        }
                }
                Text("Platycoin owned: 2") //placeholder
                    .foregroundColor(.white)
                
                //navbar
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

struct Gacha_Previews: PreviewProvider {
    static var previews: some View {
        Gacha()
    }
}

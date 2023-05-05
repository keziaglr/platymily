//
//  ContentView.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct Gacha: View {
    
    @StateObject var mc = MusicController()
    @StateObject var pvm = ProfileViewModel()
    @StateObject var svm = SetViewModel()
    @State private var isAnimating = false
    @State private var isCoin = false
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Text("Platyroll")
                    .foregroundColor(.white)
                    .font(.custom(AppFont.bold, size: 32))
                Image("GachaMachine")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(destination: GachaResult(mc: mc)){
                    RoundedButton2(text: Prompt.Button.gachaRoll, isActive: pvm.savedEntities[0].coin > 0)
                }.disabled(pvm.savedEntities[0].coin <= 0 ? true : false)
                    .opacity(pvm.savedEntities[0].coin <= 0 ? 0.5 : 1.0)
                    
                
                Text("Platycoin owned: \(pvm.savedEntities[0].coin)") //placeholder
                    .foregroundColor(.white)
                    .font(.custom(AppFont.medium, size: 14))
                
                //navbar
                Spacer()
                NavBar(mc: mc)
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

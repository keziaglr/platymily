//
//  GachaResult.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct GachaResult: View {
    
    @State private var gachaRendered = ""
    @StateObject var mc = MusicController()
    
    let gachaTypes = ["Gacha", "Gacha 2", "Gacha 3", "Gacha 4", "Gacha 5", "Gacha 6", "Gacha-Puggle"]
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: GachaObtained()) {
                VStack{
                    Image(gachaRendered)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Tap to open")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .padding(.top, 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("Background")
                    .resizable()
                    .scaledToFill())
                .ignoresSafeArea()
                .onAppear(){
                    gachaResult()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func gachaResult(){
        gachaRendered = gachaTypes.randomElement() ?? ""
    }
}

struct GachaResult_Previews: PreviewProvider {
    static var previews: some View {
        GachaResult()
    }
}

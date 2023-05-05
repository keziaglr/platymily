//
//  GachaObtained.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct GachaObtained: View {
    
    @State private var skinObtained = ""
    @StateObject var mc = MusicController()
    
    @Binding var obtainedPlatSkins: [String]
    @Binding var obtainedPugSkins: [String]
    
    let skinTypes = ["Plat 1", "Plat 2", "Plat 3", "Plat 4", "Plat 5", "Plat 6", "Plat 7", "Plat 8", "Plat 9", "Plat 10", "Plat 11", "Plat 12", "Plat 13", "Plat 14", "Pug 1", "Pug 2", "Pug 3", "Pug 4", "Pug 5", "Pug 6", "Pug 7", "Pug 8", "Pug 9", "Pug 10", "Pug 11", "Pug 12", "Pug 13", "Pug 14"]
    
    var body: some View {
        NavigationView {
            VStack{
                Text("\t  THE \nBAGUETTE") //placeholder for gacha result title
                    .padding(10)
                    .padding(.leading, 70)
                    .padding(.trailing, 70)
                    .font(.system(size: 23))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .background(.orange)
                    .cornerRadius(30)
                    .overlay{
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    }
                
                Image(skinObtained)
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(destination: GachaResult(mc: mc)) {
                    Text("Roll again")
                        .padding(10)
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(30)
                        .overlay{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 2)
                        }
                }
                HStack {
                    Text("Go to")
                        .foregroundColor(.white)
                    NavigationLink(destination: UserProfile(mc: mc)){ //destination is supposed to be the profile view
                        Text("Profile")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .underline()
                    }
                }
                .padding(.top, 10)
                
                //navbar
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear{
                skinResult()
                if skinObtained.starts(with: "Plat") {
                    obtainedPlatSkins.append(skinObtained)
                } else if skinObtained.starts(with: "Pug") {
                    obtainedPugSkins.append(skinObtained)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func skinResult(){
        skinObtained = skinTypes.randomElement() ?? ""
    }
}

struct GachaObtained_Previews: PreviewProvider {
    static var previews: some View {
        GachaObtained(obtainedPlatSkins: .constant([]), obtainedPugSkins: .constant([]))
    }
}

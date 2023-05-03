//
//  GachaObtained.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct GachaObtained: View {
    
    @State private var skinObtained = ""
    
    let skinTypes = ["Skin", "Skin 2", "Skin 3", "Skin 4", "Skin 5", "Skin 6", "Skin 7", "Skin 8", "Skin 9", "Skin 10", "Skin 11", "Skin 12", "Skin 13", "Skin 14"]
    
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
                
                NavigationLink(destination: GachaResult()) {
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
                    NavigationLink(destination: Gacha()){ //destination is supposed to be the profile view
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
        GachaObtained()
    }
}

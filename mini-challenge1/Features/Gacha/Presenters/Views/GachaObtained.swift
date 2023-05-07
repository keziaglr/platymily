//
//  GachaObtained.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct GachaObtained: View {
    
    @StateObject var mc = MusicController()
    @State var skinObtained : EntitySet
    @StateObject var svm = SetViewModel()
    @StateObject var pvm = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                
                ZStack{
                    Image("Gacha_title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    
                    Text(skinObtained.name ?? "")
                        .font(.custom(AppFont.bold, size: 23))
                        .foregroundColor(AppColor.white)
                }
                
                
                Image(skinObtained.image ?? "")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(destination: GachaResult(mc: mc)){
                    RoundedButton2(text: Prompt.Button.gachaRollAgain, isActive: pvm.savedEntities[0].coin > 0)
                }.disabled(pvm.savedEntities[0].coin <= 0 ? true : false)
                    .opacity(pvm.savedEntities[0].coin <= 0 ? 0.5 : 1.0)
                    .simultaneousGesture(TapGesture().onEnded{
                        pvm.buyGacha(coin: Int64(1))
                    })
                HStack {
                    Text("Go to")
                        .foregroundColor(.white)
                        .font(.custom(AppFont.regular, fixedSize: 16))
                    NavigationLink {
                        ProfileView(mc: mc)
                    } label: {
                        Text("Profile")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.custom(AppFont.bold,fixedSize: 16))
                            .underline()
                        
                    }
                }
                .padding(.top, 10)
                
            
                Spacer()
                NavBar(mc: mc)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
}

//struct GachaObtained_Previews: PreviewProvider {
//    static var previews: some View {
//        GachaObtained(obtainedPlatSkins: .constant([]), obtainedPugSkins: .constant([]))
//    }
//}

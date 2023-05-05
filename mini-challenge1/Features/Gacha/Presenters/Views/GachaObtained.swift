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
                
                NavigationLink(destination: GachaResult(mc: mc)) {
//                    Text("Roll again")
//                        .padding(10)
//                        .padding(.leading, 50)
//                        .padding(.trailing, 50)
//                        .font(.system(size: 22))
//                        .foregroundColor(.white)
//                        .background(.orange)
//                        .cornerRadius(30)
//                        .overlay{
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color.white, lineWidth: 2)
//                        }
                    RoundedButton(text: Prompt.Button.gachaRollAgain)
                }
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

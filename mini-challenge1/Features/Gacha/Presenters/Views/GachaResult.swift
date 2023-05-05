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
    @State var gumballAnimate = true
    @State var svm = SetViewModel()
    @State var pvm = ProfileViewModel()
    @State var skinObtained : EntitySet?
    
    let gachaTypes = ["Gacha", "Gacha 2", "Gacha 3", "Gacha 4", "Gacha 5", "Gacha 6", "Gacha-Puggle"]
    
    var body: some View {
        NavigationView {
            ZStack {
                if gumballAnimate{
                    LottieView(lottieFile: "gumballmachine", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 1.2))
                        .navigationBarBackButtonHidden(true)
                        .onAppear{
                            skinResult()
                        }
                }else{
                    NavigationLink(destination: GachaObtained(mc: mc, skinObtained: skinObtained!)) {
                        VStack{
//                            Image(gachaRendered)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 200, height: 200)
                            if gachaRendered == "Gacha"{
                                LottieView(lottieFile: "gacha_platy", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha 2"{
                                LottieView(lottieFile: "gacha_yellow", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha 3"{
                                LottieView(lottieFile: "gacha_pink", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha 4"{
                                LottieView(lottieFile: "gacha_green", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha 5"{
                                LottieView(lottieFile: "gacha_orange", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha 6"{
                                LottieView(lottieFile: "gacha_purple", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            } else if gachaRendered == "Gacha-Puggle"{
                                LottieView(lottieFile: "gacha_puggle", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), loop: false)
                            }
                            Text("Tap to open")
                                .foregroundColor(.white)
                                .font(.custom(AppFont.bold,fixedSize: 21))
                                .padding(.top, 50)
                                .padding(.bottom, 20)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear(){
                            gachaResult()
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .background(Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ).onAppear(){
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    withAnimation(.easeOut(duration: 1)) {
                        self.gumballAnimate = false
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func gachaResult(){
//        pvm.buyGacha(coin: Int64(1))
        gachaRendered = gachaTypes.randomElement() ?? ""
    }
                                   
    private func skinResult() {
        skinObtained = svm.savedEntities.randomElement()!
        svm.unlockSet(entity: skinObtained!)
    }
}

struct GachaResult_Previews: PreviewProvider {
    static var previews: some View {
        GachaResult()
    }
}

//    NavigationView {
//        ZStack {
//            if splashScreen {
//                LottieView(lottieFile: "splashscreen", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 2.4))
//                    .onAppear(){
//                        mc.playMapMusic()
//                    }
//            }else{
//                VStack {
//                    HStack {
//                        Spacer()
//                        HStack {
//                            NavigationLink {
//                                Map(mc: mc)
//                            } label: {
//                                HStack {
//                                    Text("Skip")
//                                        .foregroundColor(.white)
//                                        .font(.custom(AppFont.semibold, size: 16))
//                                    Image("NextButton")
//                                        .resizable()
//                                        .frame(width: 16, height: 16)
//                                }
//                            }
//                            
//                        }
//                        .offset(y: 35)
//                        .padding(.trailing, 30)
//                    }.opacity(showStory)
//                    Story(mc: mc)
//                        .opacity(showStory)
//                }
//                
//            }
//        }.background(
//            Image("Background")
//                .resizable()
//                .ignoresSafeArea()
//        ).onAppear(){
//            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
//                withAnimation(.easeOut(duration: 1)) {
//                    self.splashScreen = false
//                }
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                withAnimation(.easeIn(duration: 1)) {
//                    self.showStory = 1.0
//                }
//            }
//        }
//    }

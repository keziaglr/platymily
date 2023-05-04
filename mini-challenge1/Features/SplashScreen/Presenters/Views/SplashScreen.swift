//
//  SplashScreen.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var splashScreen = true
    @State var showStory = 0.0
    @StateObject var pvm = ProfileViewModel()
    @StateObject var mvm = MapViewModel()
    @StateObject var mc = MusicController()
    var body: some View {
        if mvm.savedEntities.isEmpty {
            NavigationView {
                ZStack {
                    if splashScreen {
                        LottieView(lottieFile: "splashscreen", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 2.4))
                            .onAppear(){
                                mc.playMapMusic()
                            }
                    }else{
                        VStack {
                            HStack {
                                Spacer()
                                HStack {
                                    NavigationLink {
                                        Map(mc: mc)
                                    } label: {
                                        HStack {
                                            Text("Skip")
                                                .foregroundColor(.white)
                                                .font(.custom(AppFont.semibold, size: 16))
                                            Image("NextButton")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                    }
                                    
                                }
                                .offset(y: 35)
                                .padding(.trailing, 30)
                            }.opacity(showStory)
                            Story(mc: mc)
                                .opacity(showStory)
                        }
                        
                    }
                }.background(
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                ).onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                        withAnimation(.easeOut(duration: 1)) {
                            self.splashScreen = false
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        withAnimation(.easeIn(duration: 1)) {
                            self.showStory = 1.0
                        }
                    }
                }
            }
        }else{
            ZStack{
                if splashScreen {
                    LottieView(lottieFile: "splashscreen", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 2.4))
                        .onAppear(){
                            mc.playMapMusic()
                        }
                        .background(
                            Image("Background")
                                .resizable()
                                .ignoresSafeArea()
                        )
                }else{
                    Map(mc: mc)
                }
            }.onAppear(){
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    withAnimation(.easeOut(duration: 1)) {
                        self.splashScreen = false
                    }
                }
            }
        }
    }
}

//struct SplashScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreen()
//    }
//}


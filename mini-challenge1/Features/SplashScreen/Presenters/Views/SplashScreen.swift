//
//  SplashScreen.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var splashScreen = false
    @State var showStory = 1.0
    var body: some View {
        NavigationView {
            ZStack {
                if splashScreen {
                    LottieView(lottieFile: "splashscreen", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 2.4))
                }else{
                    VStack {
                        HStack {
                            Spacer()
                            HStack {
                                NavigationLink {
                                    Map()
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
                        }
                        Story()
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
                
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                    withAnimation(.easeIn(duration: 1)) {
                        self.showStory = 1.0
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

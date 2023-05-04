//
//  PopUpReadySetGo.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct PopUpReadySetGo: View {
    @State var readyOpacity: Double = 0.2
    @State var setOpacity: Double = 0.2
    @State var goOpacity: Double = 0.2
    @State private var timer: Timer?
    @State private var showRotate: Bool = true
    @Binding var start: Bool
    @State var potrait: Bool
    @State var rotatePhone: Bool = false
    
    var body: some View {
        ZStack {
            if potrait {
                Rectangle()
                    .fill(AppColor.black)
                    .ignoresSafeArea()
                    .opacity(0.5)
                VStack(spacing:20) {
                    Text("READY")
                        .font(.custom(AppFont.bold, size: 50))
                        .foregroundColor(AppColor.white)
                        .opacity(readyOpacity)
                    Text("SET")
                        .font(.custom(AppFont.bold, size: 50))
                        .foregroundColor(AppColor.white)
                        .opacity(setOpacity)
                    Text("GO!")
                        .font(.custom(AppFont.bold, size: 50))
                        .foregroundColor(AppColor.white)
                        .opacity(goOpacity)
                }.rotationEffect(.degrees(potrait ? 0 : 270))
                .onAppear {
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            if self.readyOpacity == 0.2 {
                                self.readyOpacity = 1.0
                            } else if self.setOpacity == 0.2 {
                                self.readyOpacity = 0.1
                                self.setOpacity = 1.0
                            } else if self.goOpacity == 0.2 {
                                self.setOpacity = 0.1
                                self.readyOpacity = 0.1
                                self.goOpacity = 1.0
                                self.timer?.invalidate()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.start = true
                                }
                            }
                        }
                    }
                }
            }else{
                Rectangle()
                    .fill(AppColor.black)
                    .ignoresSafeArea()
                    .opacity(0.5)
                VStack {
                    if showRotate {
                        VStack(spacing:20){
                            Text("Rotate Your Phone")
                                .font(.custom(AppFont.bold, size: 21))
                                .foregroundColor(AppColor.white)
                            Image("Rotate")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .padding(.vertical, 50)
                                .rotationEffect(.degrees(rotatePhone ? 90 : 0))
                            Text("This Game is Horizontal")
                                .font(.custom(AppFont.bold, size: 21))
                                .foregroundColor(AppColor.white)
                        }
                    }else{
                        VStack (spacing:20){
                            Text("READY")
                                .font(.custom(AppFont.bold, size: 50))
                                .foregroundColor(AppColor.white)
                            .opacity(readyOpacity)
                            Text("SET")
                                .font(.custom(AppFont.bold, size: 50))
                                .foregroundColor(AppColor.white)
                                .opacity(setOpacity)
                            Text("GO!")
                                .font(.custom(AppFont.bold, size: 50))
                                .foregroundColor(AppColor.white)
                                .opacity(goOpacity)
                        }.rotationEffect(.degrees(potrait ? 0 : 270))
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                            rotatePhone = true
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            showRotate = false
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { _ in
                        withAnimation(Animation.easeInOut(duration: 0.2)) {
                            if self.readyOpacity == 0.2 {
                                self.readyOpacity = 1.0
                            } else if self.setOpacity == 0.2 {
                                self.readyOpacity = 0.1
                                self.setOpacity = 1.0
                            } else if self.goOpacity == 0.2 {
                                self.setOpacity = 0.1
                                self.readyOpacity = 0.1
                                self.goOpacity = 1.0
                                self.timer?.invalidate()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.start = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PopUpReadySetGo_Previews: PreviewProvider {
    static var previews: some View {
        PopUpReadySetGo(start: .constant(false), potrait: false)
    }
}

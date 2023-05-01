//
//  PopUpReadySetGo.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct PopUpReadySetGo: View {
    @State private var readyOpacity: Double = 0.2
    @State private var setOpacity: Double = 0.2
    @State private var goOpacity: Double = 0.2
    @State private var timer: Timer?
    @Binding var start: Bool
    @State var potrait: Bool
    
    var body: some View {
        ZStack {
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
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                self.start = true
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PopUpReadySetGo_Previews: PreviewProvider {
//    @State var start = false
    static var previews: some View {
        PopUpReadySetGo(start: .constant(false), potrait: false)
    }
}

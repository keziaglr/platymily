//
//  Prologue.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct Prologue: View {
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State var currentIndex = 0
    @State var showTitle = false
    @State var showButton = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    Text(Prompt.Prologue.title)
                        .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.bold, size: 42))
                        .padding(.top, 10)
                        .opacity(showTitle ? 1 : 0)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.showTitle = true
                                }
                            }
                        }
                    TextPrologue(text: Prompt.Prologue.paragraph1, interval: 3)
                    TextPrologue(text: Prompt.Prologue.paragraph2, interval: 10)
                    TextPrologue(text: Prompt.Prologue.paragraph3, interval: 15)
                    TextPrologue(text: Prompt.Prologue.paragraph4, interval: 20)
                    TextPrologue(text: Prompt.Prologue.paragraph5, interval: 25)
                    
                    NavigationLink(destination: Map(), label: {
                        RoundedButton(text: Prompt.Button.continueBtn)
                            .padding(.top, 30)
                    })
                    .opacity(showButton ? 1 : 0)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { _ in
                            withAnimation(.easeInOut(duration: 1)) {
                                self.showButton = true
                            }
                        }
                    }
                }
                .offset(y: CGFloat(currentIndex) * -180)
                    .onReceive(timer) { _ in
                        withAnimation {
                            if currentIndex < 2 {
                                currentIndex += 1
                            }
                        }
                    }
            }
            .background(
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
        )
        }
    }
}

struct Prologue_Previews: PreviewProvider {
    static var previews: some View {
        Prologue()
    }
}

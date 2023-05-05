//
//  Ending.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 05/05/23.
//

import SwiftUI

struct Ending: View {
    @State var index : Int = 0
    @State var indicator : Int = 0
    @State var text : String = Prompt.Ending.texts[0]
    @State private var offset: CGFloat = 0
    @ObservedObject var mc : MusicController
    var body: some View {
        VStack{
            switch index {
            case 0:
                LottieView(lottieFile: Prompt.Ending.animations[0], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,40)
                    .padding(.top, 50)
            case 1:
                LottieView(lottieFile: Prompt.Ending.animations[1], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,40)
                    .padding(.top, 50)
            case 2:
                LottieView(lottieFile: Prompt.Ending.animations[2], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,40)
                    .padding(.top, 50)
            case 3:
                LottieView(lottieFile: Prompt.Ending.animations[3], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,40)
                    .padding(.top, 50)
            default:
                Text("Cannot found")
            }
            BackgroundTextStory(text: $text)
                .onChange(of: index, perform: { newValue in
                    withAnimation(.easeInOut(duration: 1)) {
                        text = Prompt.Ending.texts[index]
                    }
                })
                .offset(y: -30)
                
            EndingIndicator(index: $index)
                .padding(.top, 10)
                .padding(.bottom, 20)
            NavigationLink {
                Map(mc: mc)
            } label: {
                RoundedButton(text: Prompt.Button.continueBtn)
            }
            .opacity(index == 3 ? 1.0 : 0.0)
        }.gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation.width
                }
                .onEnded { value in
                    if value.translation.width > 0 {
                        if index != 0{
                            self.index -= 1
                        }
                    } else {
                        if index != 3{
                            self.index += 1
                        }
                    }
                    self.offset = 0
                }
        )
        .background(
            Image("Background")
                .resizable()
                .ignoresSafeArea()
        )
        .onAppear{
            mc.playMapMusic()
        }
    }
}

struct Ending_Previews: PreviewProvider {
    static var previews: some View {
        Ending(mc: MusicController())
    }
}

//
//  Story.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI

struct Story: View {
    @State var index : Int = 0
    @State var indicator : Int = 0
    @State var text : String = Prompt.Story.texts[0]
    @State private var offset: CGFloat = 0
    var body: some View {
        VStack{
            switch index {
            case 0:
                LottieView(lottieFile: Prompt.Story.animations[0], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,20)
                    .padding(.top, 50)
            case 1:
                LottieView(lottieFile: Prompt.Story.animations[1], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,20)
                    .padding(.top, 50)
            case 2:
                LottieView(lottieFile: Prompt.Story.animations[2], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,20)
                    .padding(.top, 50)
            case 3:
                LottieView(lottieFile: Prompt.Story.animations[3], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,20)
                    .padding(.top, 50)
            case 4:
                LottieView(lottieFile: Prompt.Story.animations[4], animationSpeed: 1, transform: CGAffineTransform(scaleX: 1, y: 1))
                    .padding(.horizontal,20)
                    .padding(.top, 50)
            default:
                Text("Cannot found")
            }
            BackgroundTextStory(text: $text)
                .onChange(of: index, perform: { newValue in
                    text = Prompt.Story.texts[index]
                })
                
            StoryIndicator(index: $index)
                .padding(.top, 10)
                .padding(.bottom, 20)
            NavigationLink {
                Map()
            } label: {
                RoundedButton(text: Prompt.Button.continueBtn)
            }
            .opacity(index == 4 ? 1.0 : 0.0)
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
                        if index != 4{
                            self.index += 1
                        }
                    }
                    self.offset = 0
                }
        )
    }
}

struct Story_Previews: PreviewProvider {
    static var previews: some View {
        Story()
    }
}

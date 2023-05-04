//
//  BackgroundTextStory.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI

struct BackgroundTextStory: View {
    @Binding var text : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColor.white, lineWidth: 3)
                
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppColor.white)
                        .opacity(0.3)
            )
            VStack {
                Text(text)
                    .font(.custom(AppFont.bold, size: 18))
                    .foregroundColor(AppColor.navy)
                    .lineSpacing(5)
                    .padding(.top, 30)
                    .padding(.horizontal, 25)
                Spacer()
            }
                
        }.frame(width: 350, height: 350)
//        .background(
//            Color(.blue)
//        )
    }
}

struct BackgroundTextStory_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundTextStory(text: .constant("In a magical world filled with wonder and magic called Adeyca,  a small family of Platypus that lusted for adventure lived their happy story together."))
    }
}

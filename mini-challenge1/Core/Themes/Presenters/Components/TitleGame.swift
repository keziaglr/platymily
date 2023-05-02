//
//  TitleGame.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct TitleGame: View {
    @State var title: String
    var body: some View {
        ZStack{
            Image("Title")
                .resizable()
                .frame(width: 255.6, height: 117.9)
            Text(title)
                .frame(width: 100)
                .multilineTextAlignment(.center)
                .offset(x: 15, y:8)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 18))
                .textCase(.uppercase)
        }
    }
}

struct TitleGame_Previews: PreviewProvider {
    static var previews: some View {
        TitleGame(title: "Two Truths One Lie")
    }
}

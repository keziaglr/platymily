//
//  ProgressBarWin.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct ProgressBarWin: View {
    @State var score : Int
    @State var maxScore : Int
    @State var platy : Bool
    var body: some View {
        HStack{
            Image(platy ? Prompt.Role.platy : Prompt.Role.puggle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle()                 .stroke(Color.white, lineWidth: 2))
                .background(Circle().fill(AppColor.orange))
            ZStack {
                ZStack (alignment: .leading) {
                    Capsule()
                        .fill(AppColor.white)
                        .frame(width: 350, height: 40)
                        .offset(CGSize(width: -50, height: 0))
                        .overlay(Capsule()                 .stroke(AppColor.orange, lineWidth: 3).offset(CGSize(width: -50, height: 0)))
                    Capsule()
                        .fill(AppColor.orange)
                        .offset(x:-50)
                        .frame(width: progress(value: Double(self.score), maxValue: Double(self.maxScore), width: 350), height: 40)
                }.zIndex(-2)
                Text(platy ? Prompt.Role.platy : Prompt.Role.puggle)
                    .font(.custom(AppFont.bold, size: 16))
                    .foregroundColor(score == 0 || maxScore/score < 1/2 ? AppColor.orange : AppColor.white)
                    .offset(x: -130)
                    .textCase(.uppercase)
                Text("\(score)")
                    .font(.custom(AppFont.bold, size: 21))
                    .foregroundColor(maxScore == score ? AppColor.white : AppColor.orange)
                    .offset(x: 100)
            }.zIndex(-1)
           
        }.offset(CGSize(width: 25, height: 0))
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

//struct ProgressBarWin_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarWin(score: 20, maxScore: 20)
//    }
//}

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
    @State var progress: CGFloat = -1
    @ObservedObject var gvm : GameViewModel
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
                        .offset(x:-50)
                        .overlay(Capsule()                 .stroke(AppColor.orange, lineWidth: 3).offset(CGSize(width: -50, height: 0)))
                    Capsule()
                        .fill(AppColor.orange)
                        .offset(x:-50)
                        .frame(width: self.progress, height: 40)
                        .onAppear{
                            if !gvm.showPopup {
                                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                                    if progress < progress(value: Double(self.score), maxValue: Double(self.maxScore), width: 350) {
                                        self.progress += 1
                                    }
                                }
                            }
                        }
                        .onChange(of: gvm.showPopup) { newValue in
                            if !newValue {
                                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                                    if progress < progress(value: Double(self.score), maxValue: Double(self.maxScore), width: 350) {
                                        self.progress += 1
                                    }
                                }
                            }
                        }
                    
                }.zIndex(-2)
                Text(platy ? Prompt.Role.platy : Prompt.Role.puggle)
                    .font(.custom(AppFont.bold, size: 16))
                    .foregroundColor(getColor())
                    .offset(x: -130)
                    .textCase(.uppercase)
                    .multilineTextAlignment(.leading)
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
        guard maxValue > 0 else {
            return 350
        }
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
    
    func getColor()-> Color{
        if score == 0 && maxScore == 0{
            return AppColor.white
        }else if score == 0 && maxScore != 0{
            return AppColor.orange
        }else if Double(score) / Double(maxScore) > 0.2{
            return AppColor.white
        }else{
            return AppColor.orange
        }
    }
}

//struct ProgressBarWin_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
////            ProgressBarWin(score: 5, maxScore: 5, platy: true)
//            ProgressBarWin(score: 0, maxScore: 0, platy: false)
//        }
//    }
//}

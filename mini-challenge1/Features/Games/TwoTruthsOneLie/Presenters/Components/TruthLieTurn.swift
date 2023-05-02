//
//  TruthLieTurn.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 30/04/23.
//

import SwiftUI

struct TruthLieTurn: View {
    @State var role : String
    @ObservedObject var truthLieSentenceViewModel: TruthLieSentenceViewModel
    var body: some View {
        if role == Prompt.Role.platy{
            VStack {
                HStack {
                    Image(Prompt.Role.platy)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    VStack (alignment: .leading){
                        Text(Prompt.Role.platy)
                            .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.bold, size: 16))
                        Text("\(truthLieSentenceViewModel.pointPlaty) points")
                            .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.regular, size: 14))
                    }
                }
            }
        }else{
            VStack {
                HStack {
                    VStack (alignment: .trailing){
                        Text(Prompt.Role.puggle)
                            .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.bold, size: 16))
                        Text("\(truthLieSentenceViewModel.pointPuggle) points")
                            .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.regular, size: 14))
                    }
                    Image(Prompt.Role.puggle)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
            }
        }
    }
}

//struct TruthLieTurn_Previews: PreviewProvider {
//    static var previews: some View {
//        TruthLieTurn(role: Prompt.Role.platy)
//    }
//}

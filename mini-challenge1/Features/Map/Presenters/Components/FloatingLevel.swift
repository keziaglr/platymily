//
//  FloatingLevel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 27/04/23.
//

import SwiftUI

struct FloatingLevel: View {
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        Text("Winarto Family")
                            .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.bold, size: 21))
                        Image(systemName: "pencil")
                            .foregroundColor(AppColor.white)
                    }
                    Text("Level 1")
                        .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.medium, size: 14))
                }
                HStack {
                    Image("PlatyCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 46)
                        .padding(.vertical, 10)
                    .padding(.leading, 70)
                    Text("x 2")
                        .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.medium, size: 14))
                }
            }
                
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColor.orange)
                .shadow(radius: 10)
            )
    }
}

struct FloatingLevel_Previews: PreviewProvider {
    static var previews: some View {
        FloatingLevel()
    }
}

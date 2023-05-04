//
//  CustomButton.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct RoundedButton: View {
    @State var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .padding(.vertical,10)
                .padding(.horizontal, 70)
                .foregroundColor(AppColor.white)
                .fontWeight(.bold)
                .font(.custom(AppFont.medium, size: 18))
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(AppColor.orange)
                        .shadow(radius: 3)
                )
        }
    }
}

struct RectangleButton: View {
    @State var text: String
    @Binding var selected: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .foregroundColor(selected ? AppColor.white : AppColor.orange)
                .fontWeight(.bold)
                .padding(.vertical,16)
                .padding(.horizontal, 70)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(selected ? AppColor.white : AppColor.orange, lineWidth: 3)
                        .shadow(radius: 10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selected ? AppColor.orange : AppColor.white)
                        )
                    
                )
            
        }
    }
}

struct TruthLieButton: View {
    @State var text: String
    @State var color: Color
    @Binding var showColor: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 16))
                .padding(.vertical,12)
                .frame(minWidth: 350)
                .multilineTextAlignment(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(showColor ? color : AppColor.orange)
                        .shadow(radius: 5)
                )
            
        }
    }
}

//struct CustomButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RectangleButton(text: Prompt.Button.confirm, action: {
//            print("Button tapped")
//        }, selected: false)
//    }
//}

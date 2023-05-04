//
//  PopUpGameTurn.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 30/04/23.
//

import SwiftUI

struct PopUpGameTurn: View {
    @State var platyTurn: Bool
    @State var potrait: Bool
    @Binding var showPopup: Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showPopup = false
                }
            
            VStack{
                Text(Prompt.GameTurn.turn)
                    .font(.custom(AppFont.bold, size: 18))
                    .foregroundColor(AppColor.white)
                Image(platyTurn ? Prompt.Role.platy : Prompt.Role.puggle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(platyTurn ? Prompt.Role.platy : Prompt.Role.puggle)
                    .font(.custom(AppFont.bold, size: 56))
                    .foregroundColor(AppColor.white)
                    .textCase(.uppercase)
                Text(platyTurn ? Prompt.GameTurn.parent : Prompt.GameTurn.child)
                    .font(.custom(AppFont.bold, size: 28))
                    .foregroundColor(AppColor.white)
                Text(Prompt.GameTurn.tap)
                    .offset(CGSize(width: 0, height: 50))
                    .font(.custom(AppFont.medium, size: 14))
                    .foregroundColor(AppColor.white)
            }
            .rotationEffect(potrait ? .degrees(0) : .degrees(270))
            .padding(20)
            .frame(width: 350, height: 350)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AppColor.white, lineWidth: 3)
                    .shadow(radius: 10)
                    .background(
                        Image("Background")
                            .resizable()
                            .frame(width: 350, height: 350)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
            )
        }
    }
}

struct PopUpGameTurn_Previews: PreviewProvider {
    static var previews: some View {
        PopUpGameTurn(platyTurn: true, potrait: false, showPopup: .constant(true))
    }
}

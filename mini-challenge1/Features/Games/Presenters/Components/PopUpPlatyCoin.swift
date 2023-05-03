//
//  PopUpPlatyCoin.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 01/05/23.
//

import SwiftUI

struct PopUpPlatyCoin: View {
    @State var coinAmount: Int
    @StateObject var vm = ProfileViewModel()
    @ObservedObject var gvm : GameViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text(Prompt.Platycoin.congrats)
                    .font(.custom(AppFont.bold, size: 45))
                    .foregroundColor(AppColor.white)
                    .textCase(.uppercase)
                Image(Prompt.Platycoin.platycoin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text(Prompt.Platycoin.given)
                    .font(.custom(AppFont.medium, size: 14))
                    .foregroundColor(AppColor.white)
                Text("\(coinAmount) \(Prompt.Platycoin.platycoin)")
                    .font(.custom(AppFont.bold, size: 14))
                    .foregroundColor(AppColor.white)
                    .textCase(.uppercase)
                Button {
                    gvm.showPopup = false
                    vm.getCoin(coin: Int64(coinAmount))
                } label: {
                    RoundedButton(text: Prompt.Button.claimPlatycoin)
                }
            }
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

//struct PopUpPlatyCoin_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpPlatyCoin(coinAmount: 2)
//    }
//}

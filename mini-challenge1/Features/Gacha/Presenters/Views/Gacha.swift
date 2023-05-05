//
//  ContentView.swift
//  Gacha
//
//  Created by Nicholas Yvees on 25/04/23.
//

import SwiftUI

struct Gacha: View {
    
    @StateObject var mc = MusicController()
    @StateObject var pvm = ProfileViewModel()
    @StateObject var svm = SetViewModel()
    @State private var isAnimating = false
    @State private var isCoin = false
    
    func decreaseCoin(){
        pvm.buyGacha(coin: Int64(1))
        
        LottieView(lottieFile: "gumballmachine", animationSpeed: 0.8, transform: CGAffineTransform(scaleX: 1.2, y: 2.4))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Text("Platyroll")
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Image("GachaMachine")
                        .resizable()
                        .scaledToFit()
                    
                    //                    Button(action: {
                    //                        isAnimating = true
                    //                        pvm.buyGacha(coin: Int64(1))
                    //                        GachaResult(mc: mc)
                    //                    }) {
                    //                        Text("1x Roll")
                    //                            .padding(10)
                    //                            .padding(.leading, 70)
                    //                            .padding(.trailing, 70)
                    //                            .font(.system(size: 23))
                    //                            .foregroundColor(.white)
                    //                            .background(.orange)
                    //                            .cornerRadius(20)
                    //                            .overlay{
                    //                                RoundedRectangle(cornerRadius: 20)
                    //                                    .stroke(Color.white, lineWidth: 2)
                    //                            }
                    //                    }
                    
                    NavigationLink(destination: GachaResult(mc: mc), isActive: $isCoin){
                        Text("1x Roll")
                            .padding(10)
                            .padding(.leading, 70)
                            .padding(.trailing, 70)
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                            .background(.orange)
                            .cornerRadius(20)
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            }
                    }

                    Text("Platycoin owned: \(pvm.savedEntities[0].coin)") //placeholder
                        .foregroundColor(.white)
                    
                    //navbar
                    Spacer()
                    NavBar(mc: mc)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("Background")
                    .resizable()
                    .scaledToFill())
                .ignoresSafeArea()
                
                if isCoin{
                    decreaseCoin()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Gacha_Previews: PreviewProvider {
    static var previews: some View {
        Gacha()
    }
}

//
//  ContentView.swift
//  userProfile
//
//  Created by Nicholas Yvees on 26/04/23.
//

import SwiftUI

class UserProfile00: ObservableObject{
    @Published var startGame: Bool = false
    @Published var firstTap: Bool = false
    @Published var scorePlaty: Int = 0
    @Published var scorePuggle: Int = 0
    @Published var gameOver: Bool = false
    @Published var platyTurn: Bool = true
    @Published var showPopup: Bool = true
}

struct UserProfile: View {
    
    @StateObject var userProfile = UserProfile00()
    var data: [Int] = Array(1...3)
    let platypusSkin = ["Plat 1", "Plat 2", "Plat 3"]
    let puggleSkin = ["Pug 1", "Pug 2", "Pug 3"]
    let fixedRows = [
        GridItem(.fixed(90)),
    ]
    
    @State private var platyTurn: Bool = true

    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
              
                Text(userProfile.platyTurn ? "The Responsible and Mature Platypus" : "The Playful and Young Platypus")
                    .font(.custom(AppFont.regular, size: 17))
                    .foregroundColor(AppColor.white)
                    .fontWeight(.bold)
                Text(userProfile.platyTurn ? "PLATYPUS" : "PUGGLE")
                    .font(.custom(AppFont.bold, size: 28))
                    .font(.system(size: 28))
                    .foregroundColor(AppColor.white)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                
                
            }
            .padding(.top, 50)
            .padding(.bottom, 60)
            
            ZStack {
                Image("User_Floor")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .offset(x: 0, y: 70)
                HStack {
                    
                    TabView(selection: $platyTurn) {
                        Image("Platypus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .offset(y: -20)
                            .tag(true)
                        Image("Puggle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .tag(false)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onChange(of: platyTurn) { newValue in
                        userProfile.platyTurn = newValue
                    }
                    
                    
                    ZStack {
                        Image("Text_Bubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155)
                            .offset(y: -80)
                        Text("This Looks\n    Great!")
                            .font(.custom(AppFont.regular, size: 17))
                            .foregroundColor(.cyan)
                            .offset(y: -90)
                    }
                }
            }
            
            HStack{
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(userProfile.platyTurn ? AppColor.white : .cyan)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(userProfile.platyTurn ? .cyan : AppColor.white)
            }
            .padding(.bottom, 15)
            
            Button{
                
            } label: {
                RoundedButton(text: Prompt.Button.equip)
            }
            .padding()
            
            HStack(alignment: .top){
                ScrollView(.horizontal){
                    LazyHGrid(rows: fixedRows, spacing: 10){
                        ForEach(userProfile.platyTurn ? platypusSkin : puggleSkin, id: \.self){ skinName in
                            VStack {
                                Image(skinName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                    .background(Image("Background")
                                        .resizable()
                                        .scaledToFill())
                                    .cornerRadius(10)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 4)
                                    }
                                Text("The Normie") //placeholder
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 23))
                            }
                        }
                        .padding(.leading, 15)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 190)
            .background(.cyan)
            
            Spacer()
            NavBar()
                .ignoresSafeArea()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("Background")
            .resizable()
            .scaledToFill())
        .ignoresSafeArea()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

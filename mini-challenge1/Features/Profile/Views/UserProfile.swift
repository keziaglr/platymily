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
    @Published var skinEquip: String = ""
    @Published var equipped: Bool = false
}

struct UserProfile: View {
    @ObservedObject var mc : MusicController
    @State var svm = SetViewModel()
    @State var currEntity : EntitySet? = nil
    @StateObject var userProfile = UserProfile00()
    @State private var equipPlatyImageName = "Platypus"
    @State private var equipPuggleImageName = "Puggle"
    var data: [Int] = Array(1...14)
    let fixedRows = [
        GridItem(.fixed(90)),
    ]
    
    @State private var platyTurn: Bool = true
    @State private var obtainedPlatSkins: [String] = []
    @State private var obtainedPugSkins: [String] = []

    
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
                        Image(equipPlatyImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .offset(y: -20)
                            .onAppear{
                                equipPlatyImageName = svm.getEquipSet(isPlaty: true)?.image! ?? "Platypus"
                            }
                            .onChange(of: equipPlatyImageName, perform: { newValue in
                                equipPlatyImageName = svm.getEquipSet(isPlaty: true)?.image! ?? "Platypus"
                            })
                            .tag(true)
                        Image(equipPuggleImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .onAppear{
                                equipPuggleImageName = svm.getEquipSet(isPlaty: false)?.image! ?? "Puggle"
                            }
                            .onChange(of: equipPuggleImageName, perform: { newValue in
                                equipPuggleImageName = svm.getEquipSet(isPlaty: false)?.image! ?? "Puggle"
                            })
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
                if currEntity != nil {
                    if currEntity?.platy == true {
                        equipPlatyImageName = currEntity!.image!
                    }else{
                        equipPuggleImageName = currEntity!.image!
                    }
                    svm.equipSet(entity: currEntity!)
                }
            } label: {
                RoundedButton(text: Prompt.Button.equip)
            }
            .padding()
            
            HStack(alignment: .top){
                ScrollView(.horizontal){
                    LazyHGrid(rows: fixedRows, spacing: 10){
                        ForEach(userProfile.platyTurn ? svm.platySet : svm.puggleSet, id: \.self){ setEntity in
                            if !setEntity.locked {
                                VStack {
                                    Image(setEntity.image ?? "Platypus")
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
                                        .onTapGesture {
                                            currEntity = setEntity
                                            print(currEntity!.name)
                                        }
                                    Text(setEntity.name ?? "The Normie") //placeholder
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .font(.system(size: 23))
                                }
                            }else{
                                ZStack {
                                    VStack {
                                        Image(setEntity.image ?? "Platypus")
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
                                            
                                        Text(setEntity.name ?? "The Normie") //placeholder
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .font(.system(size: 23))
                                    }.opacity(0.5)
                                    Image(systemName: "lock.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .scaledToFit()
                                        .opacity(0.7)
                                    .frame(width: 30, height: 30)
                                }
                            }
                        }
                        .padding(.leading, 15)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 190)
            .background(.cyan)
            
            Spacer()
            NavBar(mc: mc)
                .ignoresSafeArea()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("Background")
            .resizable()
            .scaledToFill())
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

//struct UserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfile(mc: MusicController())
//    }
//}

//
//  ContentView.swift
//  userProfile
//
//  Created by Nicholas Yvees on 26/04/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var mc : MusicController
    @State var svm = SetViewModel()
    @State var currEntity : EntitySet? = nil
    @State var platyTurn: Bool = true
    @State private var equipPlatyImageName = "Platypus"
    @State private var equipPuggleImageName = "Puggle"
    let fixedRows = [
        GridItem(.fixed(90)),
    ]
    
    @State private var obtainedPlatSkins: [EntitySet] = []
    @State private var obtainedPugSkins: [EntitySet] = []
    
    let bubble_text = ["This looks\n    great!", "Puggle\n likes it!", "Platypus\n likes it", "OwO", "> w <"]
    @State private var textRendered = ""
    
    var body: some View {
        NavigationView(){
            
            VStack {
                Spacer()
                
                VStack {
                    Text(platyTurn ? "The Responsible and Mature Platypus" : "The Playful and Young Platypus")
                        .font(.custom(AppFont.regular, size: 17))
                        .foregroundColor(AppColor.white)
                        .fontWeight(.bold)
                    Text(platyTurn ? "PLATYPUS" : "PUGGLE")
                        .font(.custom(AppFont.bold, size: 32))
                        .foregroundColor(AppColor.white)
                }
                .padding(.top, 100)
                
                ZStack {
                    Image("User_Floor")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .offset(x: 0, y: 70)
                    HStack {
                        
                        TabView(selection: $platyTurn) {
                            ZStack {
                                Image(equipPlatyImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .offset(x: -60, y: -20)
                                    .onAppear{
                                        equipPlatyImageName = svm.getEquipSet(isPlaty: true)?.image! ?? "Platypus"
                                    }
                                    .onChange(of: equipPlatyImageName, perform: { newValue in
                                        equipPlatyImageName = svm.getEquipSet(isPlaty: true)?.image! ?? "Platypus"
                                    })
                                
                                
                                ZStack {
                                    Image("Text_Bubble")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 155)
                                        .offset(y: -80)
                                    Text(textRendered)
                                        .font(.custom(AppFont.bold, size: 17))
                                        .foregroundColor(AppColor.darkBlue)
                                        .offset(y: -90)
                                }.offset(x: 100, y: 0)
                                .onAppear(){
                                    textGenerate()
                                }
                            }.frame(width: 500, height: 500)
                                .tag(true)
                            ZStack {
                                Image(equipPuggleImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                                    .offset(x: -30)
                                    .onAppear{
                                        equipPuggleImageName = svm.getEquipSet(isPlaty: false)?.image! ?? "Puggle"
                                    }
                                    .onChange(of: equipPuggleImageName, perform: { newValue in
                                        equipPuggleImageName = svm.getEquipSet(isPlaty: false)?.image! ?? "Puggle"
                                    })
                                
                                ZStack {
                                    Image("Text_Bubble")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 155)
                                        .offset(y: -80)
                                    Text(textRendered)
                                        .font(.custom(AppFont.bold, size: 17))
                                        .foregroundColor(AppColor.darkBlue)
                                        .offset(y: -90)
                                }.offset(x: 100, y: 0)
                                    .onAppear(){
                                        textGenerate()
                                    }
                            }.frame(width: 500, height: 500)
                                .tag(false)
                        }
                        
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onChange(of: platyTurn) { newValue in
                            self.platyTurn = newValue
                        }
                        
                    }
                }
                
                VStack {
                    HStack{
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(platyTurn ? AppColor.white : AppColor.darkBlue)
                            .shadow(radius: 2)
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(platyTurn ? AppColor.darkBlue : AppColor.white)
                            .shadow(radius: 2)
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
                                ForEach(platyTurn ? obtainedPlatSkins : obtainedPugSkins, id: \.self){ setEntity in
                                    if setEntity.locked == false {
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
                                                    withAnimation(.easeInOut(duration: 0.5)) {
                                                        currEntity = setEntity
                                                                    }
                                                    
                                                }
                                            Text(setEntity.name ?? "The Normie")
                                                .font(.custom(AppFont.bold, size: currEntity == setEntity ? 16 : 14))
                                                .foregroundColor(.white)
                                        }.scaleEffect(currEntity == setEntity ? 1.15 : 1)
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
                                                
                                                Text(setEntity.name ?? "The Normie")
                                                    .font(.custom(AppFont.bold, size: 14))
                                                    .foregroundColor(.white)
                                            }.opacity(0.4)
                                            Image(systemName: "lock.fill")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .scaledToFit()
                                                .offset(y: -15)
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                }
                                .padding(.leading, 15)
                            }.onAppear(){
                                obtainedPugSkins = svm.puggleSet
                                obtainedPlatSkins = svm.platySet
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 160)
                    .background(AppColor.blue
                        .shadow(radius: 3))
                }.offset(y: -50)
                
                Spacer()
                NavBar(mc: mc)
                    .ignoresSafeArea()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("Background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
            
        }.navigationBarBackButtonHidden(true)
        
    }
    
    func textGenerate(){
        textRendered = bubble_text.randomElement() ?? ""
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(mc: MusicController())
    }
}

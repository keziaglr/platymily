//
//  GameButton'.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct GameButton: View {
    @State var type: String
    @State var title: String
    @State var desc: String
    @State var locked: Bool
    @State var image: String
    @State var imageLocked: String
    var body: some View {
        if type == "Left" {
            HStack{
                if locked {
                    ZStack {
                        Image(imageLocked)
                            .resizable()
                            .scaledToFit()
                        .frame(width: 100, height: 100)
                        Image(systemName: "lock.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .opacity(0.7)
                        .frame(width: 30, height: 30)
                    }
                }else{
                    Image(image)
                        .resizable()
                        .shadow(radius: 10)
                    .frame(width: 100, height: 100)
                }
                    
                VStack(alignment: .leading){
                    Text(title)
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.navy)
                    Text(desc)
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.navy)
                }
            }.padding(20)
        }else if type == "Right" {
            HStack{
                VStack(alignment: .trailing){
                    Text(title)
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.navy)
                    Text(desc)
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.navy)
                }
                if locked {
                    ZStack {
                        Image(imageLocked)
                            .resizable()
                            .scaledToFit()
                        .frame(width: 100, height: 100)
                        Image(systemName: "lock.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .opacity(0.7)
                        .frame(width: 30, height: 30)
                    }
                }else{
                    Image(image)
                        .resizable()
                        .shadow(radius: 10)
                    .frame(width: 100, height: 100)
                }
            }.padding(50)
        }else if type == "Up" {
            VStack{
                if locked {
                    ZStack {
                        Image(imageLocked)
                            .resizable()
                            .scaledToFit()
                        .frame(width: 120, height: 120)
                        Image(systemName: "lock.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .opacity(0.7)
                        .frame(width: 30, height: 30)
                    }
                }else{
                    Image(image)
                        .resizable()
                        .shadow(radius: 10)
                    .frame(width: 120, height: 120)
                }
                VStack(alignment: .center){
                    Text(title)
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.navy)
                    Text(desc)
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.navy)
                }
            }.padding(20)
        }
        
    }
}

struct GameButtonAction: View {
    @State var index: Int
    @Binding var showPopup : Bool
    @Binding var game : String
    @Binding var rules : String
    @Binding var image : String
    @StateObject var vm = MapViewModel()
    
    
    var body: some View {
        Button {
           showPopup = true
            self.game = vm.savedEntities[index].name ?? "Game Name"
            self.rules = vm.savedEntities[index].rules ?? "Game Rules"
            self.image = vm.savedEntities[index].image ?? "1"
        } label: {
            GameButton(type: getType(), title: getChallenge() ?? "Name Game", desc: vm.savedEntities[index].winner != "" ? "Winner: \(String( vm.savedEntities[index].winner!))" : "Locked", locked: !vm.savedEntities[index].status, image: vm.savedEntities[index].image ?? "1", imageLocked: vm.savedEntities[index].lockImage ?? "1_Locked")
        }.position(CGPoint(x: 200, y: getYPos()))
            .opacity(vm.savedEntities[index].status ? 1.0 : 0.5)
            .disabled(!vm.savedEntities[index].status)
    }
    
    
    func getType() -> String{
        if index == 5 {
            return "Up"
        }else if index % 2 == 0 {
            return "Left"
        }else{
            return "Right"
        }
    }
    
    func getYPos() -> Int{
        if index == 5{
            return 1100
        }
        return (index * 150) - 300
    }
    
    func getChallenge() -> String {
        switch index+1 {
        case 1:
            return "First Challenge"
        case 2:
            return "Second Challenge"
        case 3:
            return "Third Challenge"
        case 4:
            return "Fourth Challenge"
        case 5:
            return "Fifth Challenge"
        case 6:
            return "Sixth Challenge"
        default:
            return "Invalid Challenge Number"
        }
    }

}

//struct GameButton_Previews: PreviewProvider {
//    static var previews: some View {
//        GameButtonAction(index: 0, showPopup: .constant(false), game: .constant("hi"), rules: .constant("hi"), )
//    }
//}

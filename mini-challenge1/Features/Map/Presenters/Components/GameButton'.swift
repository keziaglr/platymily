//
//  GameButton'.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct GameButton: View {
    @State var type: String
    var body: some View {
        if type == "Left" {
            HStack{
                Image("Title")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    
                VStack(alignment: .leading){
                    Text("Game1")
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.white)
                    Text("A small description of game")
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.white)
                }
            }.padding(20)
        }else if type == "Right" {
            HStack{
                VStack(alignment: .trailing){
                    Text("Game1")
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.white)
                    Text("A small description of game")
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.white)
                }
                Image("Title")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }.padding(50)
        }else if type == "Up" {
            VStack{
                Image("Title")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                VStack(alignment: .center){
                    Text("Game1")
                        .font(.custom(AppFont.bold, size: 21))
                        .foregroundColor(AppColor.white)
                    Text("A small description of game")
                        .font(.custom(AppFont.regular, size: 14))
                        .foregroundColor(AppColor.white)
                }
            }.padding(20)
        }
        
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(type: "Up")
    }
}

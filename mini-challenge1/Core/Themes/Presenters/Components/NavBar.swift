//
//  NavBar.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 27/04/23.
//

import SwiftUI

struct NavBar: View {
    @ObservedObject var mc : MusicController
    var body: some View {
            ZStack(alignment: .leading) {
                HStack{
                    NavigationLink {
                        Map(mc: mc)
                    }label: {
                        IconNavBar(title: Prompt.Navbar.map, image: "Icon_Map")
                    }
                    NavigationLink {
//                        Map()
                    }label: {
                        IconNavBar(title: Prompt.Navbar.platyroll, image: "Icon_Platyroll")
                    }
                    NavigationLink {
                        UserProfile()
                    }label: {
                        IconNavBar(title: Prompt.Navbar.profile, image: "Icon_Profile")
                    }
                }
                    
            }.padding(.bottom, 20)
            .background(
                Rectangle()
                    .fill(AppColor.orange)
                    .shadow(radius: 3)
                    .frame(width: UIScreen.main.bounds.width)
                )
    }
}

struct IconNavBar: View{
    @State var title : String
    @State var image : String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            .padding(.horizontal, 50)
            Text(title)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 14))
                .offset(y:-7)
        }.padding(.top, 10)
    }
}

//struct NavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavBar()
//    }
//}

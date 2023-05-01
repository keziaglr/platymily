//
//  NavBar.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 27/04/23.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
            ZStack(alignment: .leading) {
                HStack{
                    NavigationLink {
                        Map()
                    }label: {
                        IconNavBar(title: Prompt.Navbar.map)
                    }
                    NavigationLink {
//                        Map()
                    }label: {
                        IconNavBar(title: Prompt.Navbar.platyroll)
                    }
                    NavigationLink {
//                        Map()
                    }label: {
                        IconNavBar(title: Prompt.Navbar.profile)
                    }
                }
                    
            }
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(AppColor.orange)
                    .shadow(radius: 10)
        )
    }
}

struct IconNavBar: View{
    @State var title : String
    var body: some View {
        VStack {
            Circle()
                .stroke(AppColor.white, lineWidth: 3)
                .frame(width: 35)
            .padding(.horizontal, 35)
            Text(title)
                .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 14))
                .offset(y:-7)
        }.padding(.top, 10)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}

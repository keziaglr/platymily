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
                IconNavBar()
                IconNavBar()
                IconNavBar()
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
    var body: some View {
        Circle()
            .stroke(AppColor.white, lineWidth: 3)
            .frame(width: 46)
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}

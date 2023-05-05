//
//  CircleIndicator.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 04/05/23.
//

import SwiftUI

struct CircleIndicator: View {
    @State var isActive : Bool
    var body: some View {
        Circle()
            .fill(isActive ? AppColor.navy : AppColor.white)
            .frame(width: 10, height: 10)
            .shadow(radius: 3)
            
    }
}

struct StoryIndicator: View{
    @Binding var index : Int
    var body: some View{
        HStack {
            ForEach(0..<5) { i in
                if index == i {
                    CircleIndicator(isActive: true)
                        .onTapGesture {
                            index = i
                        }
                }else{
                    CircleIndicator(isActive: false)
                        .onTapGesture {
                            index = i
                        }
                }
            }
        }
    }
}

struct EndingIndicator: View{
    @Binding var index : Int
    var body: some View{
        HStack {
            ForEach(0..<4) { i in
                if index == i {
                    CircleIndicator(isActive: true)
                        .onTapGesture {
                            index = i
                        }
                }else{
                    CircleIndicator(isActive: false)
                        .onTapGesture {
                            index = i
                        }
                }
            }
        }
    }
}


//struct CircleIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryIndicator()
//    }
//}

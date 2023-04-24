//
//  Map.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct Map: View {
    var body: some View {

        ScrollView {
            VStack{
                GameButton(type: "Left")
                GameButton(type: "Right")
                GameButton(type: "Left")
                GameButton(type: "Right")
                GameButton(type: "Up")
            }
            .background(
                Image("Map")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
        )
        }
    }
}

struct LineBetweenTwoPoints: View {
    var start: CGPoint
    var end: CGPoint
    var color: Color = .black
    var width: CGFloat = 1
    
    var body: some View {
        Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }
        .stroke(color, lineWidth: width)
    }
}


struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}

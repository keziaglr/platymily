//
//  Map.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct Map: View {
    @State private var showPopup = false
    @State var game = "Game Name"
    @State var rules = "Rules"
    var body: some View {
        
        NavigationView {
            ZStack {
                
                ScrollView {
                    ZStack {
                        
                        ZStack{
                            

                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: -245),
                                end: CGPoint(x: 270, y: -185),
                                control1: CGPoint(x: 180, y: -190),
                                control2: CGPoint(x: 240, y: -230))
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 270, y: -100),
                                end: CGPoint(x: 130, y: -50),
                                control1: CGPoint(x: 250, y: -25),
                                control2: CGPoint(x: 160, y: -90))
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: 55),
                                end: CGPoint(x: 270, y: 110),
                                control1: CGPoint(x: 180, y: 110),
                                control2: CGPoint(x: 240, y: 65))
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 270, y: 200),
                                end: CGPoint(x: 130, y: 250),
                                control1: CGPoint(x: 250, y: 275),
                                control2: CGPoint(x: 160, y: 210))
                            
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: 350),
                                end: CGPoint(x: 200, y: 430),
                                control1: CGPoint(x: 140, y: 400),
                                control2: CGPoint(x: 180, y: 375))
                            
                            
                            Button {
                               showPopup = true
                                self.game = Prompt.Games.game1.title
                                self.rules = Prompt.Games.game1.rules
                            } label: {
                                GameButton(type: "Left", title: Prompt.Games.game1.title, desc: "Locked")
                            }.position(CGPoint(x: 200, y: -300))
                            
                            Button {
                                showPopup = true
                                 self.game = Prompt.Games.game2.title
                                 self.rules = Prompt.Games.game2.rules
                            } label: {
                                GameButton(type: "Right", title: Prompt.Games.game2.title, desc: "Locked")
                            }.position(CGPoint(x: 200, y: -150))
                            
                            Button {
                                showPopup = true
                                 self.game = Prompt.Games.game3.title
                                 self.rules = Prompt.Games.game3.rules
                            } label: {
                                GameButton(type: "Left", title: Prompt.Games.game3.title, desc: "Locked")
                                
                            }.position(CGPoint(x: 200, y: 0))
                            
                            Button {
                                showPopup = true
                                 self.game = Prompt.Games.game4.title
                                 self.rules = Prompt.Games.game4.rules
                            } label: {
                                GameButton(type: "Right", title: Prompt.Games.game4.title, desc: "Locked")
                            }.position(CGPoint(x: 200, y: 150))
                            
                            
                            Button {
                                showPopup = true
                                 self.game = Prompt.Games.game5.title
                                 self.rules = Prompt.Games.game5.rules
                            } label: {
                                GameButton(type: "Left", title: Prompt.Games.game5.title, desc: "Locked")
                            }.position(CGPoint(x: 200, y: 300))
                            
                            
                            
                        }.padding(.vertical, 600)
                        .background(
                            Image("Map")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
                                .scaledToFill()
                    )
                    }
                }.edgesIgnoringSafeArea(.all)
                
                    

                VStack{
                    FloatingLevel()
                    Spacer()
                    NavBar()
                }
                if showPopup{
                    PopUpGamePreview(title: $game, rules: rules, showPopup: $showPopup)
                }
                    
            }
        }
    }
}

struct LineBetweenTwoPoints: View {
    var start: CGPoint
    var end: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var color: Color = AppColor.navy
    var width: CGFloat = 3
    
    var body: some View {
        Path { path in
            path.move(to: start)
            path.addCurve(
                    to: end,
                    control1: control1,
                    control2: control2)
        }
        .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, dash: [8]))
        .foregroundColor(color)
        
    }
}

extension CGPoint {
    func midPoint(to point: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + point.x) / 2, y: (self.y + point.y) / 2)
    }
}


struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}

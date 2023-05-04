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
    @State var image = "1"
    @ObservedObject var mc : MusicController
    @StateObject var vm = MapViewModel()
    var body: some View {
        
        NavigationView {
            ZStack {
                
                ScrollView {
                    ZStack {
                        
                        ZStack{
                            

                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: -245),
                                end: CGPoint(x: 270, y: -200),
                                control1: CGPoint(x: 180, y: -190),
                                control2: CGPoint(x: 240, y: -230))
                            .opacity(vm.savedEntities[1].status ? 1.0 : 0)
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 270, y: -90),
                                end: CGPoint(x: 130, y: -50),
                                control1: CGPoint(x: 250, y: -25),
                                control2: CGPoint(x: 160, y: -90))
                            .opacity(vm.savedEntities[2].status ? 1.0 : 0)
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: 55),
                                end: CGPoint(x: 265, y: 100),
                                control1: CGPoint(x: 180, y: 110),
                                control2: CGPoint(x: 240, y: 65))
                            .opacity(vm.savedEntities[3].status ? 1.0 : 0)
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 270, y: 210),
                                end: CGPoint(x: 130, y: 250),
                                control1: CGPoint(x: 250, y: 275),
                                control2: CGPoint(x: 160, y: 210))
                            .opacity(vm.savedEntities[4].status ? 1.0 : 0)
                            
                            
                            LineBetweenTwoPoints(
                                start:CGPoint(x: 130, y: 355),
                                end: CGPoint(x: 200, y: 410),
                                control1: CGPoint(x: 140, y: 400),
                                control2: CGPoint(x: 180, y: 375))
                            .opacity(vm.savedEntities[5].status ? 1.0 : 0)
                            
                            
                            GameButtonAction(index: 0, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                            GameButtonAction(index: 1, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                            GameButtonAction(index: 2, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                            GameButtonAction(index: 3, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                            GameButtonAction(index: 4, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                           
                            
                        }.padding(.vertical, 600)
                        .background(
                            Image("Map")
                                .resizable()
                                .edgesIgnoringSafeArea(.all)
                                .scaledToFill()
                    )
                        GameButtonAction(index: 5, showPopup: $showPopup, game: $game, rules: $rules, image: $image)
                    }
                }.edgesIgnoringSafeArea(.all)
                
                    
                
                VStack{
                    Spacer()
                    NavBar(mc: mc)
                }.ignoresSafeArea()
                
                VStack{
                    FloatingLevel()
                        .padding(.top, 60)
                    Spacer()
                }.ignoresSafeArea()
                if showPopup{
                    PopUpGamePreview(title: $game, rules: rules, image: image, showPopup: $showPopup, mc: mc)
                }
                    
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct LineBetweenTwoPoints: View {
    var start: CGPoint
    var end: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var color: Color = AppColor.navy
    var width: CGFloat = 3
    @State private var trimStart: CGFloat = 0
    @State private var trimEnd: CGFloat = 0
    var body: some View {
        Path { path in
            path.move(to: start)
            path.addCurve(
                    to: end,
                    control1: control1,
                    control2: control2)
        }
        .trim(from: trimStart, to: trimEnd)
        .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, dash: [8]))
        .foregroundColor(color)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).delay(0.5)) {
                self.trimEnd = 1
            }
        }
        
    }
}

extension CGPoint {
    func midPoint(to point: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + point.x) / 2, y: (self.y + point.y) / 2)
    }
}


struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map(mc: MusicController())
    }
}

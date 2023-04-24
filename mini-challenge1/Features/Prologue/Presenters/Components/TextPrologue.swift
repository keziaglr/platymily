//
//  TextPrologue.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 23/04/23.
//

import SwiftUI

struct TextPrologue: View {
    @State var text : String
    @State var interval : Double
    @State var show = false
    
    var body: some View {
        Text(text)
            .font(.custom(AppFont.regular, size: 16))
            .foregroundColor(AppColor.white)
            .padding(18)
            .lineSpacing(10)
            .opacity(show ? 1 : 0)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
                    withAnimation(.easeInOut(duration: 1)) {
                        self.show = true
                    }
                }
            }
    }
}

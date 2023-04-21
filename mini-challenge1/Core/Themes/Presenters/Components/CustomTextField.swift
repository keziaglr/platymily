//
//  CustomTextField.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 21/04/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
        
    var body: some View {
        ZStack{
            
            ZStack(alignment: .leading) {
                TextField("", text: $text)
                    .foregroundColor(AppColor.orange)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppColor.orange, lineWidth: 3)
                    .shadow(radius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(AppColor.white)
                    )
                
            )
        }.padding(.horizontal, 15)
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField(text: "hi")
//    }
//}

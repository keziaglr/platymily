//
//  FloatingLevel.swift
//  mini-challenge1
//
//  Created by Kezia Gloria on 27/04/23.
//

import SwiftUI
import Combine

struct FloatingLevel: View {
    @State var isEdit = false
    @State var textValue = ""
    @StateObject var vm = ProfileViewModel()
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        ZStack{
                            VStack (alignment: .leading) {
                                Text(vm.savedEntities[0].name ?? "Family Name")
                                        .foregroundColor(AppColor.white)
                                    .font(.custom(AppFont.bold, size: 21))
                                    .opacity(isEdit ? 0 : 1)
                                    .frame(width: 150, height: 10, alignment: .leading)
                                .fixedSize()
                            }
                            if isEdit{
                                TextField(vm.savedEntities[0].name ?? "Family Name", text: $textValue)
                                    .foregroundColor(AppColor.white)
                                    .font(.custom(AppFont.bold, size: 21))
                                    .frame(width: 150, height: 10)
                                    .onAppear {
                                        isTextFieldFocused = true
                                    }
                                    .fixedSize(horizontal: true, vertical: true)
                                    .focused($isTextFieldFocused)
                                    .onSubmit {
                                        if textValue != ""{
                                        vm.updateName(name: textValue)
                                            isEdit.toggle()
                                        }else{
                                            textValue = vm.savedEntities[0].name ?? "Family Name"
                                        }
                                    }
                                    
                            }
                            
                        }
                        Image(systemName: "pencil")
                            .foregroundColor(AppColor.white)
                            .onTapGesture {
                                if textValue != ""{
                                vm.updateName(name: textValue)
                                    isEdit.toggle()
                                    isTextFieldFocused = true
                                }else{
                                    textValue = vm.savedEntities[0].name ?? "Family Name"
                                }
                            }
                    }
                    Text("Level \(vm.savedEntities[0].level)")
                        .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.medium, size: 14))
                }
                Spacer()
                HStack {
                    Image("PlatyCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(.vertical, 10)
                    .padding(.leading, 30)
                    Text("x \(vm.savedEntities[0].coin)")
                        .foregroundColor(AppColor.white)
                        .font(.custom(AppFont.medium, size: 14))
                }
            }
                
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColor.orange)
                .shadow(radius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.07)
            )
    }
}

struct MaxTextField: View{
    var body: some View{
        VStack (alignment: .leading) {
            Text("Family")
                    .foregroundColor(AppColor.white)
                .font(.custom(AppFont.bold, size: 21))
                .frame(width: 150, height: 10)
            .fixedSize()
        }
    }
}

struct FloatingLevel_Previews: PreviewProvider {
    static var previews: some View {
        MaxTextField()
    }
}

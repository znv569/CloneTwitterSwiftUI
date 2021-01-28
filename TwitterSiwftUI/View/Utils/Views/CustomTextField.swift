//
//  CustomTextField.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let imgSysName: String
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.init(white: 1, alpha: 0.87)))
                    .padding(.leading, 40)
            }
            HStack(spacing: 14){
                Image(systemName: imgSysName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Color(.init(white: 1, alpha: 0.7)))
                TextField("", text: $text)
                    .foregroundColor(.white)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: "Email", imgSysName: "envelope")
    }
}

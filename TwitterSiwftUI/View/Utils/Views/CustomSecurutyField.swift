//
//  CustomSecurutyField.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI

struct CustomSecurutyField: View {
    @Binding var text: String
    let placeholder: String
    let imgSysName: String
    let onComit: ()-> Void
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
                SecureField("", text: $text,  onCommit: onComit)
                    .foregroundColor(.white)
              
            }
        }
    }
}

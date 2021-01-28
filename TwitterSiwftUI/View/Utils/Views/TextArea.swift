//
//  TextArea.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI

struct TextArea: View {
    let placeholder: String
    @Binding var text: String
    
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        ZStack(alignment: .topLeading){

                Text(placeholder)
                    .opacity(text.isEmpty ? 1 : 0)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
            
            
            TextEditor(text: $text)
                .frame(minHeight: 20, maxHeight: 140)
                .padding(4)
        }
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea("What's happened?", text: .constant(""))
    }
}

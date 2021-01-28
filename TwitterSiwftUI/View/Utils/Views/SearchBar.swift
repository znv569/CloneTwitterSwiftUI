//
//  SearchBar.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State var showText: String = ""
    @State var editing: Bool = false
    var placeholder: String
    
    
    init(text: Binding<String>, placeholder: String) {
        self.placeholder = placeholder
        self._text = text
        self._showText = State(initialValue: "\(text.wrappedValue)")
    }
    
    
    var body: some View {
        
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 17, height: 17)
                    .padding(.horizontal, 10)
                ZStack(alignment: .leading){
                    
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .opacity(showText.isEmpty ? 1 : 0)
                    
                    TextField("", text: $showText, onEditingChanged: { (result) in
                        self.editing = result
                    }).onChange(of: showText, perform: { value in
                        text = value
                    })
                }
                
                
                
                Button(action: {
                    self.showText = ""
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 12, height: 12)
                        .padding(5)
                        .background(Color.gray)
                        .clipShape(Circle())
                })
                .padding(.horizontal, 8)
                .opacity(showText.isEmpty ? 0 : 1)
            }
            .frame(minWidth: 200, maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(15)
            
            
            
            Button(action: {
                showText = ""
                UIApplication.shared.endEditing()
            }, label: {
                Text("Cancel")
                    .foregroundColor(.blue)
                    .font(.system(size: 17))
            }).offset(x: editing ? 0 : 150)
            .frame(width: editing ? 60 : 0,  height: 15, alignment: .center)
            .animation(.interpolatingSpring(mass: 2, stiffness: 100, damping: 12, initialVelocity: 0))
            
        }
        .padding()
        
    }
    
    
    
}




struct SearchBar_Prewies: PreviewProvider {
    static var previews: some View{
        SearchBar(text: .constant("444"), placeholder: "Input the text")
    }
}




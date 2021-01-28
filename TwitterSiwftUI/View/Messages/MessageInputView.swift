//
//  MessageInputView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 07.01.2021.
//

import SwiftUI

struct MessageInputView: View {
    
        @Binding var text: String
        @State var textHeight: CGFloat = 0
        
    var textFieldHeight: CGFloat {
        
        
        let minHeight: CGFloat = 30
        let maxHeight: CGFloat = 140
        
        if textHeight < minHeight {
            return minHeight
        }
        
        if textHeight > maxHeight {
            return maxHeight
        }
        
        return textHeight
    }
    
    var onChangeHeight: (()->Void)? = nil
        
    var sendMes: (()->Void)? = nil
    
    
    
    var body: some View {
        HStack{
           
                       
            TextView(text: $text, heightText: $textHeight, placeholder: "Message text")
               .frame(height: textFieldHeight)
            
            Button(action: {
                sendMes?()
            }, label: {
                Text("Send")
            })

            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
          
        }.onChange(of: textFieldHeight) { _ in
            onChangeHeight?()
        }
       
    }
    
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(text: .constant(""))
    }
}

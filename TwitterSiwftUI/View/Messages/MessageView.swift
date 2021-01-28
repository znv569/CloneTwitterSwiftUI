//
//  MessageView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 07.01.2021.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    
    @Binding var message: MessageMock
    var user: User
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 14){
            if message.isCurrentUser {
                HStack(spacing: 0){
                    Spacer()
                    Text(message.message)
                        .frame(minWidth: 30, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .clipShape(ChatBublbe(isCurrentUser: true))
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                   
                    
                }
                
        }else{
            KFImage(user.profileImageUrl)
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
                .clipShape(Circle())
            Text(message.message)
                .frame(minWidth: 30)
                .padding()
                .background(Color(.systemGray5))
                .clipShape(ChatBublbe(isCurrentUser: false))
                .foregroundColor(.black)
                .font(.system(size: 14))
                
                
            }
            Spacer()
        }
        .padding(.leading)
        
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView(message: .constant(MESSAGE_TEST[2]))
//    }
//}

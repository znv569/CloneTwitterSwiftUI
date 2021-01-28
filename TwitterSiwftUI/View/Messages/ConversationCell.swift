//
//  ConversationCell.swift
//  TwitterSiwftUI
//
//  Created by Admin on 30.12.2020.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    @State var chat: Chat
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack(alignment: .top, spacing: 6, content: {
                KFImage(chat.user.profileImageUrl)
                    .resizable()
                    .frame(width: 54, height: 54, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
                    
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(chat.user.fullname)
                        .font(.system(size: 14, weight: .semibold))
                    Text(chat.lastMessage)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(3)
                })
                .foregroundColor(.black)
                Spacer()
            })
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            
            Divider()
        }
        .background(chat.read ? Color.white : Color.blue.opacity(0.1))
        
    }
}

//struct ConversationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationCell(chat: <#T##Chat#>)
//    }
//}

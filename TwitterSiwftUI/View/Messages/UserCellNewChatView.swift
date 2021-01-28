//
//  UserCellNewChatView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 18.01.2021.
//

import SwiftUI

struct UserCellNewChatView: View {
    let user: User
    @State var showChat: Bool = false
    
    var body: some View {
        Button(action: {
            
            showChat.toggle()

        }, label: {
            UserCell(user: user)
        })
        .sheet(isPresented: $showChat, content: {
            NavigationView{
                ChatView(user)
                    .navigationBarItems(leading: Button(action: {self.showChat.toggle()}, label: {
                        Image(systemName: "chevron.backward")
                    }))
                    
            }
        })
    }
}

//struct UserCellNewChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCellNewChatView()
//    }
//}

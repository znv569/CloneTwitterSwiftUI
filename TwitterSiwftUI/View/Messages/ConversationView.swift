//
//  ConversationView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 30.12.2020.
//

import SwiftUI

struct ConversationView: View {
    
    @State var isShowingNewMessage: Bool = false
    @ObservedObject var viewModel = ConversationViewModel()
    @State var showUserList = false
    
    var body: some View {
        
        
        ZStack(alignment: .bottomTrailing, content: {
            
            ScrollView{
                VStack(spacing: 10){
                    ForEach(viewModel.chats) { chat in
                        NavigationLink(
                            destination: NavigationLazyView( ChatView(chat.user) ),
                            label: {
                                ConversationCell(chat: chat)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            })
                       
                    }
                }
            }
            
            
            Button(action: {self.showUserList.toggle()}, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32, alignment: .center)
                    .padding(20)

            })
            .foregroundColor(.white)
            .background(Color(.systemBlue))
            .cornerRadius(32 / 2)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showUserList, content: {
                NewMessageView( show: $showUserList)
            })
            
        }).onAppear{
            viewModel.addListener()
        }
        .onDisappear{
            viewModel.removeLister()
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}

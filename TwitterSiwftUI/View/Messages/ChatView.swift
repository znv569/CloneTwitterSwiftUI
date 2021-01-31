//
//  ChatView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 07.01.2021.
//

import SwiftUI

struct ChatView: View {
    
    let user: User
    
    
    @State var messageText: String = ""
    @ObservedObject var viewModel: ChatViewModel
    @ObservedObject var keyboard = KeyboardObserve()
    
    init(_ user: User) {
        self.user = user
        self.viewModel = ChatViewModel(user)
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 3, content: {
            
            
            ScrollViewReader{ sr in
                ScrollView{
                
                    VStack(alignment: .leading, spacing: 9){

                        ForEach(viewModel.messages, id: \.self.id) { message in
                            
                            MessageView(message: .constant(message), user: user)
                        }
                    }
                    .onChange(of: keyboard.currentHeight, perform: { newHeigth in
                        withAnimation {
                            sr.scrollTo(viewModel.messages.last!.id, anchor: .bottom)
                        }
                    })
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            sr.scrollTo(viewModel.messages.last!.id, anchor: .bottom)
                        }
                    }
                    
                    
                }.onTapGesture{
                    UIApplication.shared.endEditing()
                }
                
                
                
                
                Divider()
                MessageInputView(text: $messageText, onChangeHeight: {
                    withAnimation {
                        sr.scrollTo(viewModel.messages.last!.id, anchor: .bottom)
                    }
                }, sendMes: {
                    let forSend: String = messageText
                        messageText = ""
                    self.viewModel.sendMessage(message: forSend) {
                        //messageText = ""
                        print(messageText)
                    }
                })
                .padding()
                
                
                
                
            }.onAppear{
                viewModel.addListener()
            }.onDisappear{
                viewModel.removeListener()
            }
            
           
            
   
        
           
          
        })
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(User())
    }
}

//
//  ChatViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 16.01.2021.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    
    let user: User
    @Published var messages = [MessageMock]()
    var listener: ListenerRegistration?
    
    init(_ user: User){
        self.user = user
    }
    
    
    
    
    
    func sendMessage(message: String, compleation: @escaping()->Void){
        MessageService.shared.sendMessage(user, message: message) {
            compleation()
        }
    }
    
    func addListener(){
        HudShowing.shared.showHud(true)
        listener?.remove()
      listener = MessageService.shared.listerMessages(user) { messages in
            self.messages = messages
            HudShowing.shared.showHud(false)
        }
    }
    
    func removeListener(){
        listener?.remove()
    }
    
}

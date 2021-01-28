//
//  ConversationViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 18.01.2021.
//

import SwiftUI
import Firebase


class ConversationViewModel: ObservableObject {
    
    var listener: ListenerRegistration?
    @Published var chats = [Chat]()
    
    func addListener(){
        listener?.remove()
       listener = MessageService.shared.listenChat { (chats) in
            self.chats = chats
        }
    }
    
    
    func removeLister(){
        listener?.remove()
    }
}

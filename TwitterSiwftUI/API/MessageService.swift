//
//  MessageService.swift
//  TwitterSiwftUI
//
//  Created by Admin on 17.01.2021.
//

import Firebase
import Foundation



class MessageService {
    
    static let shared = MessageService()
    
    
    var uid: String {
        return Auth.auth().currentUser!.uid
    }
    
    
    func sendMessage(_ user: User, message: String, compleation: @escaping()->Void){
        var value: [String: Any] = ["inbox": false,
                                    "timestamp": Timestamp(),
                                    "read": true,
                                    "lastMessage": message]
        USERS_REF.document(uid).collection("chats").document(user.id).setData(value) { _ in
            
            value["inbox"] = true
            value["read"] = false
            
            USERS_REF.document(user.id).collection("chats").document(self.uid).setData(value) { _ in
                var valueMessage: [String: Any] = ["inbox": false,
                                                   "message": message,
                                                   "timestamp": Timestamp()]
                USERS_REF.document(self.uid).collection("chats").document(user.id).collection("messages").addDocument(data: valueMessage) { _ in
                    valueMessage["inbox"] = true
                    USERS_REF.document(user.id).collection("chats").document(self.uid).collection("messages").addDocument(data: valueMessage) { _ in
                        compleation()
                    }
                }
            }
        }
    }
    
    
    func listerMessages(_ user: User, compleation: @escaping([MessageMock])->Void) -> ListenerRegistration{
        let listener = USERS_REF.document(uid).collection("chats").document(user.id).collection("messages").order(by: "timestamp", descending: false).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            var messages = [MessageMock]()
            self.readChat(user.id)
            snapshot.documents.forEach { document in
                let dictionary = document.data()
                let inbox = dictionary["inbox"] as! Bool
                let profileImagesUrl: URL
                
                if inbox {
                    profileImagesUrl = user.profileImageUrl
                }else{
                    profileImagesUrl = AuthViewModel.shared.user!.profileImageUrl
                }
                
                let message = MessageMock(dictionary: dictionary, profileImageUrl: profileImagesUrl, id: document.documentID)
                messages.append(message)
            }
            
            compleation(messages)
        }
        return listener
    }
    
    
    func readChat(_ chatId: String){
        let value = ["read": true]
        USERS_REF.document(uid).collection("chats").document(chatId).updateData(value)
    }
    
    
    func listenChat(compleation: @escaping([Chat])->Void) -> ListenerRegistration{
        let listener = USERS_REF.document(uid).collection("chats").order(by: "timestamp", descending: true).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let count = snapshot.count
            var chats = [Chat]()
            snapshot.documents.forEach { (document) in
                let dictionary = document.data()
                UserService.shared.fetchUser(document.documentID) { user in
                    let chat = Chat(dictionary: dictionary, user: user)
                    chats.append(chat)
                    if count == chats.count {
                        chats.sort{$0.timestamp > $1.timestamp}
                        compleation(chats)
                    }
                }
            }
            
        }
        
        return listener
    }
    
    
}

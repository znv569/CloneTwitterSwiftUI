//
//  Message.swift
//  TwitterSiwftUI
//
//  Created by Admin on 07.01.2021.
//

import Foundation
import Firebase


//model chat
struct MessageMock: Identifiable {
    let id: String
    let message: String
    let profileImageUrl: URL
    let timestamp: Date
    let isCurrentUser: Bool
    
    
    init(dictionary: [String: Any], profileImageUrl: URL, id: String) {
        self.id = id
        self.message = dictionary["message"] as? String ?? ""
        self.timestamp = (dictionary["timestamp"] as! Timestamp).dateValue()
        self.isCurrentUser = !(dictionary["inbox"] as! Bool)
        self.profileImageUrl = profileImageUrl
    }
}


//model preview chats in list
struct Chat: Identifiable {
    let id: String
    let user: User
    let lastMessage: String
    let timestamp: Date
    let read: Bool
    let inbox: Bool
    
    init(dictionary: [String: Any], user: User){
        self.id = UUID().uuidString
        self.user = user
        self.timestamp = (dictionary["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        self.read = dictionary["read"] as? Bool ?? false
        self.inbox = dictionary["inbox"] as? Bool ?? false
        self.lastMessage = dictionary["lastMessage"] as? String ?? ""
    }
}



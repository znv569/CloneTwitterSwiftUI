//
//  Tweet.swift
//  TwitterSiwftUI
//
//  Created by Admin on 14.01.2021.
  

import Foundation
import Firebase
 
class Tweet: Identifiable, ObservableObject {
    @Published var user: User
    @Published var likes: Int
    @Published var timestamp: Date
    @Published var caption: String
    @Published var id: String
               let ref:  DocumentReference
    var reply: String?
    var timesort: Date?
    

    
    init(user: User, ref: DocumentReference, id: String, dictionary: [String: Any]) {
        self.user = user
        self.likes = dictionary["likes"] as? Int ?? 0
        self.timestamp = (dictionary["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        self.caption = dictionary["caption"] as? String ?? ""
        self.reply = dictionary["reply"] as? String
        self.id = id
        self.ref = ref
    }
    
    init(){
        self.likes = 10
        self.timestamp = Date()
        self.caption = "test tweet"
        self.id = UUID().uuidString
        self.ref = TWEETS_REF.document("dddd")
        self.user = User()
    }
}

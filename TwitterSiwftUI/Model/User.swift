//
//  File.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//

import SwiftUI
import Firebase



class User: Identifiable, ObservableObject{
  
    
    let id: String
    @Published var username: String
    @Published var fullname: String
    @Published var profileImageUrl: URL
    @Published var email: String
    @Published var caption: String

    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.profileImageUrl = URL(string: dictionary["profileImageUrl"] as! String)!
        
    }
    
    
    init(){
        self.id = UUID().uuidString
        self.username = "batmanttest"
        self.fullname = "Bruce Waine"
        self.email = "email@email.com"
        self.caption = "Caption about batman"
        self.profileImageUrl = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2FcUKLWL3Vm_3PLlGrEwnpHacn3PWy93GJg&usqp=CAU")!
    }
}





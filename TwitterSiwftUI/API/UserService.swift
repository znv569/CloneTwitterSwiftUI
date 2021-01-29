//
//  UserService.swift
//  TwitterSiwftUI
//
//  Created by Admin on 12.01.2021.
//

import Foundation
import Firebase



class UserService {
    
    private var currentUser: String? {
        return Auth.auth().currentUser?.uid
    }
    
    
    
    
    static let shared = UserService()
    
    
    func updateUser(_ user: User, pass: String, compleation: @escaping()->Void){
        let value:[String: Any] = ["caption": user.caption,
                                   "fullname": user.fullname,
                                   "username": user.username,
                                   "email": user.email,
                                   "profileImageUrl": user.profileImageUrl.absoluteString]
        
        USERS_REF.document(user.id).updateData(value) { _ in
            Auth.auth().currentUser?.updateEmail(to: user.email, completion: { _ in
                if !pass.isEmpty {
                    Auth.auth().currentUser?.updatePassword(to: pass, completion: nil)
                }
                  compleation()
                
            })
        }
        
        
    }
    
    func fetchUser(_ uid: String? = nil, compleation: @escaping(User)->Void){
        
        
        var uidQuery: String? = nil
        
        if let uid = uid {
            uidQuery = uid
        }else{
            uidQuery = currentUser
        }
        
        
        guard let uid = uidQuery else {  return  }
        
        USERS_REF.document(uid).getDocument { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            
            let dictionary = snapshot.data()
            
            let user = User(dictionary: dictionary!)
            
            compleation(user)
        }
    }
    
    
    
    
    func fetchUsers(compleation: @escaping([User])->Void){
        
        USERS_REF.getDocuments { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            
            
            var users = snapshot.documents.map{ User(dictionary: $0.data())}
            users.sort{$0.fullname > $1.fullname }
            
            compleation(users)
        }
    }
    
    
    
    func follow(_ user: User, compleation: @escaping()->Void){
        guard let uid = currentUser else {return}
        let value: [String: Any] = ["uid": uid,
                                  "toUser": user.id]
        FOLLOW_REF.addDocument(data: value) { error in
            if error == nil {
                compleation()
            }
        }
    }
    
    
    
    func unfollow(_ user: User, compleation: @escaping()->Void){
        guard let uid = currentUser else {return}
        FOLLOW_REF.whereField("uid", isEqualTo: uid).whereField("toUser", isEqualTo: user.id).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            snapshot.documents.forEach { document in
                FOLLOW_REF.document(document.documentID).delete { error in
                    if error == nil {
                        compleation()
                    }
                }
            }
        }
    }
    
    
    func checkFollow(_ user: User, compleation: @escaping(Bool)->Void){
        guard let uid = currentUser else {return}
        
        FOLLOW_REF.whereField("uid", isEqualTo: uid).whereField("toUser", isEqualTo: user.id).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            snapshot.documents.isEmpty ? compleation(false) : compleation(true)
            
        }
    }
    
    struct CountFollow {
        let followers: Int
        let following: Int
    }
    
    func getCountFollow(_ user: User, compleation: @escaping(CountFollow)->Void){
        
        
      
        
        FOLLOW_REF.whereField("toUser", isEqualTo: user.id).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            let followers = snapshot.documents.count
            
            FOLLOW_REF.whereField("uid", isEqualTo: user.id).getDocuments { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                let following = snapshot.documents.count
                
                compleation(CountFollow(followers: followers, following: following))
            }
            
            
            
        }
    }
    
}

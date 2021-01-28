//
//  AuthService.swift
//  TwitterSiwftUI
//
//  Created by Admin on 12.01.2021.
//

import UIKit
import Firebase

struct Credentials {
    let email: String
    let username: String
    let password: String
    let image: UIImage
    let fullname: String
}

class AuthService {
    
    static let shared = AuthService()
    
    
    enum ResultOption {
        case success
        case error(Error)
    }
    
    
    func registerUser(_ credentials: Credentials, compleation: @escaping(ResultOption)->Void){
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (data, error) in
            guard error == nil else{
                compleation(.error(error!))
                return
            }
            
            let uid = data!.user.uid
            
            let filename = UUID().uuidString
            let fileRef = STORAGE_PROFILE_IMAGES.child(filename)
            
            guard let dataImg = credentials.image.jpegData(compressionQuality: 0.3) else {
              
                return
            }
            
            fileRef.putData(dataImg, metadata: nil) { (_, error) in
                guard error == nil else {
                    compleation(.error(error!))
                    return
                }
                fileRef.downloadURL { (url, error) in
                    guard error == nil else {
                        compleation(.error(error!))
                        return
                    }
                    if let url =  url?.absoluteString {
                        let values: [String: Any] = ["uid": uid,
                                                     "username": credentials.username,
                                                     "fullname": credentials.fullname,
                                                     "profileImageUrl": url,
                                                     "email": credentials.email]
                        
                        USERS_REF.document(uid).setData(values) { (error) in
                            if let error = error {
                                compleation(.error(error))
                            }else{
                                compleation(.success)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    
    func loginEmail(_ email: String, pass: String, compleation: @escaping(ResultOption)->Void){
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                compleation(.error(error))
            }else{
                compleation(.success)
            }
        }
    }
    
    
}






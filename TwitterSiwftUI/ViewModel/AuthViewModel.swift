//
//  AuthentificationViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI
import Firebase
import Combine


class AuthViewModel: ObservableObject {
    
    @Published var currentUser: Firebase.User?
    @Published var user: User?{
        didSet {
            if user != nil {
                observeObjectUser()
            }else{
                canceler?.cancel()
            }
        }
    }
    private var canceler: AnyCancellable?
    
    static let shared = AuthViewModel()
    
    
    init(){
        self.currentUser = Auth.auth().currentUser
        observeUser()
        fetchUser()
    }
    
    
    func fetchUser(){
        guard let currentUser = currentUser else { return}
        UserService.shared.fetchUser(currentUser.uid) { user in
            self.user = user
        }
    }
    func observeObjectUser(){

        canceler?.cancel()
        canceler = self.user?.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        })
       
    }
    
    func observeUser(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.currentUser = user
            self.fetchUser()
        }
    }
    
    func logOut(){
        try? Auth.auth().signOut()
        self.currentUser = Auth.auth().currentUser
    }
    
    func login(email: String, pass: String, compleation: @escaping(AuthService.ResultOption)->Void){
        AuthService.shared.loginEmail(email, pass: pass) { (result) in
            compleation(result)
        }
    }
    
    
    func registerUser(email: String, password: String, login: String, fullname: String, profileImage: UIImage){
        let credentials = Credentials(email: email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), username: login.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), password: password, image: profileImage, fullname: fullname)
        
        AuthService.shared.registerUser(credentials) { (result) in
            switch result {
            
            case .success:
                print("Успех")
               // self.currentUser = Auth.auth().currentUser
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



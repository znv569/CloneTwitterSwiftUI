//
//  EditProfileViewModel.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.01.2021.
//

import SwiftUI



class EditpRofileViewModel: ObservableObject {
    
    var user: User
    
    
    @Published var password: String = ""
    @Published var profileImageUrl: URL
    @Published var username: String
    @Published var email: String
    @Published var fullname: String
    @Published var caption: String
    @Published var selectedImage: UIImage?
    
    init(){
        let user = AuthViewModel.shared.user!
        self.user = user
        self.profileImageUrl = user.profileImageUrl
        self.username = user.username
        self.email = user.email
        self.fullname = user.fullname
        self.caption = user.caption
    }
    
    
    
    func saveProfile(compleation: @escaping()->Void){
        HudShowing.shared.showHud(true)
        user.caption = caption
        user.profileImageUrl = profileImageUrl
        user.email = email
        user.fullname = fullname
        user.username = username
        
        UserService.shared.updateUser(user, pass: password) {
            HudShowing.shared.showHud(false)
            compleation()
        }
    }
    
}

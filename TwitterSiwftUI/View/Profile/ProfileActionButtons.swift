//
//  ProfileActionButtons.swift
//  TwitterSiwftUI
//
//  Created by Admin on 10.01.2021.
//

import SwiftUI

struct ProfileActionButtons: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var isPresentedEditProfile: Bool = false
    
    
    var body: some View {
        
       
        
        if viewModel.user.isCurrentUser {
            Button(action: {
                isPresentedEditProfile.toggle()
            }, label: {
                Text("Edit profile")
            })
            .frame(minWidth: 100, maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 10)
            .padding(.horizontal, 40)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.horizontal)
            .fullScreenCover(isPresented: $isPresentedEditProfile, content: {
                EditProfileView()
            })
            
        }else{
            HStack(spacing: 10){
                Button(action: {
                    viewModel.follow()
                }, label: {
                    
                    if viewModel.isFollowed == nil {
                        Text("Loading...")
                    }else{
                        Text(viewModel.isFollowed! ? "Unfollow" : "Follow")
                    }
                    
                })
                .disabled(viewModel.isFollowed == nil)
                .frame(minWidth: 100, maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
                .padding(.vertical, 10)
                .background((viewModel.isFollowed ?? false) ? Color(#colorLiteral(red: 0.9486505389, green: 0.4501413703, blue: 1, alpha: 1)).opacity(0.7) : Color(#colorLiteral(red: 0.9486505389, green: 0.4501413703, blue: 1, alpha: 1)))
                .clipShape(Capsule())
                .overlay(RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color.white, lineWidth: 0.75))
                .shadow(color: Color.black.opacity(0.5), radius: 4)
                
             
                
        
                
                
                NavigationLink(
                    destination: NavigationLazyView( ChatView(User() )  ),
                    label: {
                        Text("Send Message")
                       
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .overlay(RoundedRectangle(cornerRadius: 140)
                                    .stroke(Color.white, lineWidth: 0.75) )
                       
                        .shadow(color: Color.black.opacity(0.5), radius: 4)
                    })
           
                
               
            }.padding(.horizontal)
        }
        
    }
}

struct ProfileActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtons(viewModel: ProfileViewModel(user: User()))
    }
}


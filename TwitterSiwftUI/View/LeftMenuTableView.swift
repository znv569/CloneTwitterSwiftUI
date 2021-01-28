//
//  LeftMenuTableView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 11.01.2021.
//

import SwiftUI
import Firebase
import Kingfisher
struct LeftMenuTableView: View {
    
    @State var presented: Bool = false
    @ObservedObject var authViewModel: AuthViewModel
    @State var profilePresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer()
                Button(action: {
                    profilePresented.toggle()
                }, label: {
                    KFImage(authViewModel.user?.profileImageUrl)
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 1.5))
                        .shadow(color: .black, radius: 5)
                        .padding()
                })
                .fullScreenCover(isPresented: $profilePresented, content: {
                    if authViewModel.user !== nil {
                        NavigationView{
                            UserProfileView(authViewModel.user!)
                                .navigationBarItems(leading: Button(action: {
                                    profilePresented.toggle()
                                }, label: {
                                    Text("Close")
                                }))
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        
                    }
                })
               
           
                
                Spacer()
            }
            
            
            Button(action: {
                
                authViewModel.logOut()
                UIApplication.shared.dismiss()
           
                
            }, label: {
                HStack{
                    Text("Log Out")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                    
                
                    
                }
            })
            
            
            Spacer()
               
        }
        .navigationBarHidden(true)
        .background(Color.blue.edgesIgnoringSafeArea(.all))
    }
}

struct LeftMenuTableView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuTableView(authViewModel: AuthViewModel())
    }
}

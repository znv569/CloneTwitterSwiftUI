//
//  ProfileHeaderView.swift
//  TwitterSiwftUI
//
//  Created by Admin on 10.01.2021.
//

import SwiftUI
import Kingfisher



struct ProfileHeaderView: View {
    
   
    @ObservedObject var viewModel: ProfileViewModel
   

    
    var body: some View {
        VStack(spacing: 8){
        
            KFImage(viewModel.user.profileImageUrl)
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .scaledToFill()
                .clipShape(Circle())
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 120)
                            .stroke(Color.white, lineWidth: 2))
                .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            
            VStack(spacing: 3){
                Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                Text(viewModel.user.username)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            Text(viewModel.user.caption)
                .lineLimit(2)
                .font(.system(size: 14))
            
            HStack(spacing: 40){
                
                VStack{
                    Text(String(viewModel.followers))
                        .font(.system(size: 16, weight: .bold))
                    Text("Folowers")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                
                VStack{
                    Text(String(viewModel.following))
                        .font(.system(size: 16, weight: .bold))
                    Text("Folowing")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            ProfileActionButtons(viewModel: viewModel)
            FilterButtonView(selectedOption: $viewModel.optionFilter)
            
        }
    }
    
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView(optionFilter: .constant(.likes))
//    }
//}

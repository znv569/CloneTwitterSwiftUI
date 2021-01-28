//
//  UserCell.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//
import Kingfisher
import SwiftUI

struct UserCell: View {
   @ObservedObject  var user: User
    
    var body: some View {
        HStack(alignment: .center, spacing: 8, content: {
          
            KFImage(user.profileImageUrl)
                
                .resizable()
                .scaledToFill()
                .frame(width: 52, height: 52, alignment: .center)
                .clipShape(Circle())
                .clipped()
                .padding(.leading, 10)
            VStack(alignment: .leading, spacing: 4, content: {
                Text(user.username)
                    .font(.system(size: 14, weight: .bold))
                Text(user.fullname)
                    .font(.system(size: 16, weight: .regular))
                                        
            }) .foregroundColor(.black)
            
            Spacer()
                
        }).frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 10)
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}

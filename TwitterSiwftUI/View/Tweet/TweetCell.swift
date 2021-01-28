//
//  TweetCell.swift
//  TwitterSiwftUI
//
//  Created by Admin on 29.12.2020.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    @ObservedObject var viewModel: TweetViewModel
    
    init(_ tweet: Tweet){
        self.viewModel = TweetViewModel(tweet)
    }
    
    init(_ viewModel: TweetViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if viewModel.tweet.reply != nil {
                HStack{
                    Spacer()
                Text("replying to  @\(viewModel.tweet.reply!)")
                    .foregroundColor(.blue)
                    .font(.system(size: 14))
                    .padding(.vertical, 3)
                    Spacer()
                }
            }
            
            HStack(alignment: .top, spacing: 10){
                KFImage(viewModel.tweet.user.profileImageUrl)
                    .resizable()
                    .clipped()
                    .cornerRadius(56 / 2)
                    .frame(width: 56, height: 56, alignment: .center)
                    .aspectRatio(contentMode: ContentMode.fill)
                    .padding(.leading, 7)
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Text(viewModel.tweet.user.fullname)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                        NavigationLink(
                            destination: NavigationLazyView( UserProfileView(viewModel.tweet.user) ),
                            label: {
                                Text("@\(viewModel.tweet.user.username)    •")
                                    .foregroundColor(.gray)
                            })
                        
                            
                        
                        Text(viewModel.tweet.timestamp.dayExpire)
                            .foregroundColor(.gray)
                           
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                        })
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }
                    
                    
                    Text(viewModel.tweet.caption)
                        .lineLimit(2)
                        .foregroundColor(.black)
                       
                }
                .padding(.bottom, 10)
            }
            
            ActionTweetButtonView(viewModel: viewModel)
            Divider()
        }
   
    }
}

struct TweetCell_Previews: PreviewProvider {
    static var previews: some View {
        TweetCell(Tweet())
    }
}
